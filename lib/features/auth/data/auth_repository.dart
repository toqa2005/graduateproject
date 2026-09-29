import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:graduateproject/firebase_options.dart';

import 'google_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> loginWithGoogle() async {
    await GoogleAuth.login();
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? avatarAsset,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;

    if (user == null) {
      throw Exception('Registration failed');
    }

    await user.updateDisplayName(name);

    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'uid': user.uid,
      'avatarAsset': avatarAsset,
      'customAvatarBase64': null,
    });
  }

  Future<void> resetPassword({required String email}) async {
    final apiKey = DefaultFirebaseOptions.currentPlatform.apiKey;

    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/'
      'accounts:sendOobCode?key=$apiKey',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'requestType': 'PASSWORD_RESET', 'email': email}),
    );

    if (response.statusCode != 200) {
      final data = jsonDecode(response.body);

      final error = data['error']?['message'] ?? 'Reset password failed';

      throw Exception(error);
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    String? avatarAsset,
    String? customAvatarBase64,
    bool clearCustomAvatar = false,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User not found');
    }

    await user.updateDisplayName(name);

    final data = <String, dynamic>{'name': name, 'phone': phone};

    if (avatarAsset != null) {
      data['avatarAsset'] = avatarAsset;
    }

    if (clearCustomAvatar) {
      data['customAvatarBase64'] = null;
    } else if (customAvatarBase64 != null) {
      data['customAvatarBase64'] = customAvatarBase64;
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(data, SetOptions(merge: true));
  }

  Future<void> deleteAccount({required String password}) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No signed-in user found.',
      );
    }

    final hasPasswordProvider = user.providerData.any(
      (provider) => provider.providerId == 'password',
    );

    if (!hasPasswordProvider || user.email == null) {
      throw FirebaseAuthException(
        code: 'operation-not-allowed',
        message: 'Password deletion is available for email/password accounts.',
      );
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
    await _firestore.collection('users').doc(user.uid).delete();
    await user.delete();
  }
}
