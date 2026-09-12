import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/colors.dart';

class GoogleAuth {
  static Future<void> login(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser =
      await GoogleSignIn.instance.authenticate();

      print('Google Email: ${googleUser.email}');
      print('Google Name: ${googleUser.displayName}');
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      print('ID Token: ${googleAuth.idToken}');

      final AuthCredential credential =
      GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final User? user = userCredential.user;

      print('Firebase UID: ${user?.uid}');
      print('Firebase Email: ${user?.email}');
      print('Firebase Provider: ${user?.providerData}');

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ' success',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('Firebase Error Code: ${e.code}');
      print('Firebase Error Message: ${e.message}');

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Firebase Error: ${e.code}\n${e.message}',
          ),
          backgroundColor: Appcolor.red,
        ),
      );
    } catch (e) {
      print('Google Error: $e');

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
          backgroundColor: Appcolor.red,
        ),
      );
    }
  }
}