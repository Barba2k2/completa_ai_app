import '../models/section.dart';
import '../services/firebase_service.dart';

class SectionRepository {
  Future<List<Section>> getSections() async {
    final snapshot = await FirebaseService.sectionsCollection
        .orderBy('order')
        .get();

    return snapshot.docs.map((doc) => Section.fromFirestore(doc)).toList();
  }

  Future<Section?> getSectionById(String id) async {
    final doc = await FirebaseService.sectionsCollection.doc(id).get();

    if (!doc.exists) return null;
    return Section.fromFirestore(doc);
  }

  Stream<List<Section>> watchSections() {
    return FirebaseService.sectionsCollection
        .orderBy('order')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Section.fromFirestore(doc)).toList());
  }
}
