import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/sticker.dart';
import '../../../shared/models/user_sticker.dart';
import '../../../shared/repositories/sticker_repository.dart';
import '../../auth/providers/auth_provider.dart';

final stickerRepositoryProvider = Provider<StickerRepository>((ref) {
  return StickerRepository();
});

final stickersBySectionProvider =
    StreamProvider.family<List<Sticker>, String>((ref, sectionId) {
  final repository = ref.read(stickerRepositoryProvider);
  return repository.watchStickersBySection(sectionId);
});

final userStickersProvider = StreamProvider<Map<String, UserSticker>>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (user) {
      if (user == null) return Stream.value({});
      return ref.read(stickerRepositoryProvider).watchUserStickers(user.uid);
    },
    loading: () => Stream.value({}),
    error: (_, _) => Stream.value({}),
  );
});

final stickerServiceProvider = Provider<StickerService>((ref) {
  return StickerService(ref);
});

class StickerService {
  final Ref _ref;

  StickerService(this._ref);

  Future<void> toggleStickerOwned(String stickerId) async {
    final user = _ref.read(authStateProvider).value;
    if (user == null) return;

    await _ref
        .read(stickerRepositoryProvider)
        .toggleStickerOwned(userId: user.uid, stickerId: stickerId);
  }

  Future<void> incrementRepeated(String stickerId) async {
    final user = _ref.read(authStateProvider).value;
    if (user == null) return;

    await _ref
        .read(stickerRepositoryProvider)
        .incrementRepeated(userId: user.uid, stickerId: stickerId);
  }

  Future<void> decrementRepeated(String stickerId) async {
    final user = _ref.read(authStateProvider).value;
    if (user == null) return;

    await _ref
        .read(stickerRepositoryProvider)
        .decrementRepeated(userId: user.uid, stickerId: stickerId);
  }
}
