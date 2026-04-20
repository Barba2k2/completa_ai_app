import '../../core/network/api_client.dart';
import '../models/user_sticker.dart';

class CollectionApiService {
  final ApiClient _apiClient;

  CollectionApiService(this._apiClient);

  Future<Map<String, UserSticker>> getCollection() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/collection');
    final stickers = response['stickers'] as Map<String, dynamic>? ?? {};

    return stickers.map((key, value) {
      if (value is int) {
        return MapEntry(
          key,
          UserSticker(
            stickerId: key,
            isOwned: value > 0,
            repeatedCount: value > 1 ? value - 1 : 0,
          ),
        );
      }
      return MapEntry(key, UserSticker.fromJson(value as Map<String, dynamic>));
    });
  }

  Future<void> updateCollection(Map<String, int> stickers) async {
    await _apiClient.put('/collection', data: {'stickers': stickers});
  }

  Future<Map<String, UserSticker>> syncCollection({
    required Map<String, int> stickers,
    required DateTime clientTime,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/collection/sync',
      data: {
        'stickers': stickers,
        'client_time': clientTime.toIso8601String(),
      },
    );

    final syncedStickers = response['stickers'] as Map<String, dynamic>? ?? {};
    return syncedStickers.map((key, value) {
      if (value is int) {
        return MapEntry(
          key,
          UserSticker(
            stickerId: key,
            isOwned: value > 0,
            repeatedCount: value > 1 ? value - 1 : 0,
          ),
        );
      }
      return MapEntry(key, UserSticker.fromJson(value as Map<String, dynamic>));
    });
  }

  Future<void> updateSticker({
    required String stickerId,
    required int quantity,
  }) async {
    await _apiClient.patch(
      '/collection/stickers/$stickerId',
      data: {'quantity': quantity},
    );
  }
}
