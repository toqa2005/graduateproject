import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:graduateproject/features/home/data/movie_model.dart';

class ProfileRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  ProfileRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  DocumentReference<Map<String, dynamic>> get _userDoc {
    final user = currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return _firestore.collection('users').doc(user.uid);
  }

  CollectionReference<Map<String, dynamic>> get _watchList =>
      _userDoc.collection('watchList');

  CollectionReference<Map<String, dynamic>> get _history =>
      _userDoc.collection('history');

  Future<Map<String, dynamic>> getUserProfile() async {
    final user = currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    final snapshot = await _userDoc.get();
    final data = snapshot.data() ?? <String, dynamic>{};

    return {
      'name': (data['name'] as String?)?.trim().isNotEmpty == true
          ? (data['name'] as String).trim()
          : (user.displayName?.trim().isNotEmpty == true
                ? user.displayName!.trim()
                : user.email?.split('@').first ?? 'User'),
      'avatarAsset': data['avatarAsset'] as String?,
      'customAvatarBase64': data['customAvatarBase64'] as String?,
    };
  }

  Future<String> getUserName() async {
    final profile = await getUserProfile();

    return profile['name'] as String? ?? 'User';
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<List<Movies>> getWatchList() async {
    final snapshot = await _watchList
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => Movies.fromJson(doc.data())).toList();
  }

  Future<List<Movies>> getHistory() async {
    final snapshot = await _history
        .orderBy('visitedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => Movies.fromJson(doc.data())).toList();
  }

  Future<void> addToWatchList(Movies movie) async {
    if (movie.id == null) {
      throw Exception('Movie id is missing');
    }

    final data = movie.toJson();

    data['createdAt'] = DateTime.now().millisecondsSinceEpoch;

    await _watchList.doc(movie.id.toString()).set(data);
  }

  Future<void> removeFromWatchList(int movieId) async {
    await _watchList.doc(movieId.toString()).delete();
  }

  Future<bool> isInWatchList(int movieId) async {
    final doc = await _watchList.doc(movieId.toString()).get();

    return doc.exists;
  }

  Future<void> addToHistory(Movies movie) async {
    if (movie.id == null) {
      throw Exception('Movie id is missing');
    }

    final data = movie.toJson();

    data['visitedAt'] = DateTime.now().millisecondsSinceEpoch;

    await _history.doc(movie.id.toString()).set(data);
  }

  Future<void> clearHistory() async {
    final snapshot = await _history.get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
