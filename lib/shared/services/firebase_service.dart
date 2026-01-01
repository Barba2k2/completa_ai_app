import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;

  static User? get currentUser => auth.currentUser;

  static String? get currentUserId => currentUser?.uid;

  static bool get isAuthenticated => currentUser != null;
}
