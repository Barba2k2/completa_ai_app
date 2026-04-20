import '../models/user_profile.dart';
import '../services/user_api_service.dart';

class UserRepository {
  final UserApiService _apiService;

  UserRepository(this._apiService);

  Future<UserProfile?> getUserProfile() async {
    try {
      return await _apiService.getProfile();
    } catch (_) {
      return null;
    }
  }

  Future<UserProfile?> updateProfileFields({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async {
    try {
      return await _apiService.updateProfile(
        displayName: displayName,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
      );
    } catch (_) {
      return null;
    }
  }

  Future<bool> deleteUserProfile() async {
    try {
      await _apiService.deleteAccount();
      return true;
    } catch (_) {
      return false;
    }
  }
}
