import '../models/sticker.dart';
import '../models/user_sticker.dart';
import '../services/firebase_service.dart';

class StickerRepository {
  Future<List<Sticker>> getStickersBySection(String sectionId) async {
    final snapshot = await FirebaseService.stickersCollection
        .where('sectionId', isEqualTo: sectionId)
        .orderBy('number')
        .get();

    return snapshot.docs.map((doc) => Sticker.fromFirestore(doc)).toList();
  }

  Future<Sticker?> getStickerById(String id) async {
    final doc = await FirebaseService.stickersCollection.doc(id).get();

    if (!doc.exists) return null;
    return Sticker.fromFirestore(doc);
  }

  Stream<List<Sticker>> watchStickersBySection(String sectionId) {
    return FirebaseService.stickersCollection
        .where('sectionId', isEqualTo: sectionId)
        .orderBy('number')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Sticker.fromFirestore(doc)).toList());
  }

  Future<Map<String, UserSticker>> getUserStickers(String userId) async {
    final snapshot =
        await FirebaseService.userStickersCollection(userId).get();

    final map = <String, UserSticker>{};
    for (final doc in snapshot.docs) {
      map[doc.id] = UserSticker.fromFirestore(doc);
    }
    return map;
  }

  Stream<Map<String, UserSticker>> watchUserStickers(String userId) {
    return FirebaseService.userStickersCollection(userId)
        .snapshots()
        .map((snapshot) {
      final map = <String, UserSticker>{};
      for (final doc in snapshot.docs) {
        map[doc.id] = UserSticker.fromFirestore(doc);
      }
      return map;
    });
  }

  Future<void> updateUserSticker({
    required String userId,
    required String stickerId,
    required bool isOwned,
    required int repeatedCount,
  }) async {
    await FirebaseService.userStickersCollection(userId).doc(stickerId).set({
      'isOwned': isOwned,
      'repeatedCount': repeatedCount,
      'updatedAt': DateTime.now(),
    });
  }

  Future<void> toggleStickerOwned({
    required String userId,
    required String stickerId,
  }) async {
    final doc =
        await FirebaseService.userStickersCollection(userId).doc(stickerId).get();

    if (doc.exists) {
      final data = doc.data();
      final currentOwned = data?['isOwned'] as bool? ?? false;
      await doc.reference.update({
        'isOwned': !currentOwned,
        'repeatedCount': !currentOwned ? 0 : (data?['repeatedCount'] ?? 0),
        'updatedAt': DateTime.now(),
      });
    } else {
      await FirebaseService.userStickersCollection(userId).doc(stickerId).set({
        'isOwned': true,
        'repeatedCount': 0,
        'updatedAt': DateTime.now(),
      });
    }
  }

  Future<void> incrementRepeated({
    required String userId,
    required String stickerId,
  }) async {
    final doc =
        await FirebaseService.userStickersCollection(userId).doc(stickerId).get();

    if (doc.exists) {
      final data = doc.data();
      final currentCount = data?['repeatedCount'] as int? ?? 0;
      await doc.reference.update({
        'isOwned': true,
        'repeatedCount': currentCount + 1,
        'updatedAt': DateTime.now(),
      });
    } else {
      await FirebaseService.userStickersCollection(userId).doc(stickerId).set({
        'isOwned': true,
        'repeatedCount': 1,
        'updatedAt': DateTime.now(),
      });
    }
  }

  Future<void> decrementRepeated({
    required String userId,
    required String stickerId,
  }) async {
    final doc =
        await FirebaseService.userStickersCollection(userId).doc(stickerId).get();

    if (doc.exists) {
      final data = doc.data();
      final currentCount = data?['repeatedCount'] as int? ?? 0;
      if (currentCount > 0) {
        await doc.reference.update({
          'repeatedCount': currentCount - 1,
          'updatedAt': DateTime.now(),
        });
      }
    }
  }
}
