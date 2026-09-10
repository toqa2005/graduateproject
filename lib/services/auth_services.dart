import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {

      UserCredential result =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {

        await user.updateDisplayName(name);


        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'uid': user.uid,
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print("AUTH ERROR: ${e.code}");
      print("AUTH MESSAGE: ${e.message}");
      return null;
    } on FirebaseException catch (e) {
      print("FIRESTORE ERROR: ${e.code}");
      print("FIRESTORE MESSAGE: ${e.message}");
      return null;
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }
}