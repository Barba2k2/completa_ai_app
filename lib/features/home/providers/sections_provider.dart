import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/section.dart';
import '../../../shared/repositories/section_repository.dart';

final sectionRepositoryProvider = Provider<SectionRepository>((ref) {
  return SectionRepository();
});

final sectionsProvider = StreamProvider<List<Section>>((ref) {
  final repository = ref.read(sectionRepositoryProvider);
  return repository.watchSections();
});

final sectionByIdProvider =
    FutureProvider.family<Section?, String>((ref, sectionId) async {
  final repository = ref.read(sectionRepositoryProvider);
  return repository.getSectionById(sectionId);
});
