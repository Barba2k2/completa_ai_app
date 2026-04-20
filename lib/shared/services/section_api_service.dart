import '../../core/network/api_client.dart';
import '../models/section.dart';

class SectionApiService {
  final ApiClient _apiClient;

  SectionApiService(this._apiClient);

  Future<List<Section>> getSections() async {
    final response = await _apiClient.get<List<dynamic>>('/sections');
    return response
        .map((json) => Section.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Section> getSectionById(String id) async {
    final response = await _apiClient.get<Map<String, dynamic>>('/sections/$id');
    return Section.fromJson(response);
  }
}
