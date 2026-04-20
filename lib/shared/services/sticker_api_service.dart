import '../../core/network/api_client.dart';
import '../models/sticker.dart';

class StickerApiService {
  final ApiClient _apiClient;

  StickerApiService(this._apiClient);

  Future<List<Sticker>> getStickersBySection(String sectionId) async {
    final response = await _apiClient.get<List<dynamic>>(
      '/stickers',
      queryParameters: {'sectionId': sectionId},
    );
    return response
        .map((json) => Sticker.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Sticker> getStickerById(String id) async {
    final response = await _apiClient.get<Map<String, dynamic>>('/stickers/$id');
    return Sticker.fromJson(response);
  }

  Future<List<Sticker>> searchStickers(String query) async {
    final response = await _apiClient.get<List<dynamic>>(
      '/stickers/search',
      queryParameters: {'q': query},
    );
    return response
        .map((json) => Sticker.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
