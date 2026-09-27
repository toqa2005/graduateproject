import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'google_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> loginWithGoogle() async {
    await GoogleAuth.login();
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    final UserCredential result =
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User? user = result.user;

    if (user == null) {
      throw Exception("Registration failed");
    }

    await user.updateDisplayName(name);

    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'uid': user.uid,
    });
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not found");
    }

    await user.updateDisplayName(name);

    await _firestore.collection('users').doc(user.uid).update({
      'name': name,
      'phone': phone,
    });
  }
}