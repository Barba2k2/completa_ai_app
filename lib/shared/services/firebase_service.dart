import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;

  static CollectionReference<Map<String, dynamic>> get usersCollection =>
      firestore.collection('users');

  static CollectionReference<Map<String, dynamic>> get sectionsCollection =>
      firestore.collection('sections');

  static CollectionReference<Map<String, dynamic>> get stickersCollection =>
      firestore.collection('stickers');

  static CollectionReference<Map<String, dynamic>> userStickersCollection(
    String userId,
  ) =>
      usersCollection.doc(userId).collection('stickers');

  static User? get currentUser => auth.currentUser;

  static String? get currentUserId => currentUser?.uid;

  static bool get isAuthenticated => currentUser != null;
}
