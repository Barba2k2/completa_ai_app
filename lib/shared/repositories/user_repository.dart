import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_profile.dart';
import '../services/firebase_service.dart';

class UserRepository {
  Future<UserProfile?> getUserProfile(String userId) async {
    final doc = await FirebaseService.usersCollection.doc(userId).get();

    if (!doc.exists) return null;
    return UserProfile.fromFirestore(doc);
  }

  Future<void> createUserProfile(UserProfile profile) async {
    await FirebaseService.usersCollection.doc(profile.id).set({
      'email': profile.email,
      'displayName': profile.displayName,
      'photoUrl': profile.photoUrl,
      'totalOwned': profile.totalOwned,
      'totalRepeated': profile.totalRepeated,
      'createdAt': Timestamp.fromDate(profile.createdAt),
      'lastLoginAt': profile.lastLoginAt != null
          ? Timestamp.fromDate(profile.lastLoginAt!)
          : null,
    });
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    await FirebaseService.usersCollection.doc(profile.id).update({
      'displayName': profile.displayName,
      'photoUrl': profile.photoUrl,
      'phoneNumber': profile.phoneNumber,
      'totalOwned': profile.totalOwned,
      'totalRepeated': profile.totalRepeated,
      'lastLoginAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> updateProfileFields({
    required String userId,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async {
    final updates = <String, dynamic>{};
    if (displayName != null) updates['displayName'] = displayName;
    if (photoUrl != null) updates['photoUrl'] = photoUrl;
    if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;

    if (updates.isNotEmpty) {
      await FirebaseService.usersCollection.doc(userId).update(updates);
    }
  }

  Future<void> updateLastLogin(String userId) async {
    await FirebaseService.usersCollection.doc(userId).update({
      'lastLoginAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> updateLoginWithProviderData({
    required String userId,
    String? displayName,
    String? photoUrl,
  }) async {
    final updates = <String, dynamic>{
      'lastLoginAt': Timestamp.fromDate(DateTime.now()),
    };

    if (displayName != null) updates['displayName'] = displayName;
    if (photoUrl != null) updates['photoUrl'] = photoUrl;

    await FirebaseService.usersCollection.doc(userId).update(updates);
  }

  Future<void> updateStickerCounts({
    required String userId,
    required int totalOwned,
    required int totalRepeated,
  }) async {
    await FirebaseService.usersCollection.doc(userId).update({
      'totalOwned': totalOwned,
      'totalRepeated': totalRepeated,
    });
  }

  Stream<UserProfile?> watchUserProfile(String userId) {
    return FirebaseService.usersCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserProfile.fromFirestore(doc);
    });
  }
}
