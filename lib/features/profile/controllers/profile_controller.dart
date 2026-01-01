import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/models/user_profile.dart';
import '../../../shared/repositories/user_repository.dart';
import '../../../shared/services/firebase_service.dart';

class ProfileController extends ChangeNotifier {
  final UserRepository _userRepository;
  final ImagePicker _imagePicker;

  UserProfile? _profile;
  bool _isLoading = false;
  String? _error;
  File? _selectedImage;
  bool _profileSaved = false;

  ProfileController()
      : _userRepository = UserRepository(),
        _imagePicker = ImagePicker();

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  File? get selectedImage => _selectedImage;
  bool get profileSaved => _profileSaved;

  void clearProfileSaved() {
    _profileSaved = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> saveProfile({
    required String displayName,
    String? phoneNumber,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      String? photoUrl = _profile?.photoUrl;

      if (_selectedImage != null) {
        photoUrl = await uploadImage(_selectedImage!);
      }

      final success = await updateProfile(
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
      );

      if (success) {
        _selectedImage = null;
        _profileSaved = true;
      }
    } catch (e) {
      log('[ProfileController] Error saving profile: $e');
      _error = 'Erro ao salvar perfil';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProfile() async {
    final userId = FirebaseService.currentUserId;
    if (userId == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _userRepository.getUserProfile(userId);
    } catch (e) {
      log('[ProfileController] Error loading profile: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> uploadImage(File image) async {
    final userId = FirebaseService.currentUserId;
    if (userId == null) return null;

    try {
      final ref =
          FirebaseService.storage.ref().child('profile_images/$userId.jpg');

      await ref.putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      return await ref.getDownloadURL();
    } catch (e) {
      log('[ProfileController] Error uploading image: $e');
      return null;
    }
  }

  Future<bool> updateProfile({
    required String displayName,
    String? phoneNumber,
    String? photoUrl,
  }) async {
    final userId = FirebaseService.currentUserId;
    if (userId == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await _userRepository.updateProfileFields(
        userId: userId,
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
      );

      _profile = _profile?.copyWith(
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
      );

      return true;
    } catch (e) {
      log('[ProfileController] Error updating profile: $e');
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
