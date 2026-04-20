import '../../core/network/api_client.dart';
import '../models/user_profile.dart';

class UserApiService {
  final ApiClient _apiClient;

  UserApiService(this._apiClient);

  Future<UserProfile> getProfile() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/profile');
    return UserProfile.fromJson(response);
  }

  Future<UserProfile> updateProfile({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '/profile',
      data: {
        if (displayName != null) 'displayName': displayName,
        if (photoUrl != null) 'photoUrl': photoUrl,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
      },
    );
    return UserProfile.fromJson(response);
  }

  Future<void> deleteAccount() async {
    await _apiClient.delete('/auth/account');
  }
}
