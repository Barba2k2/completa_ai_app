import 'dart:developer';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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

  ProfileController(
    this._userRepository,
  ) : _imagePicker = ImagePicker();

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
    } catch (e, stack) {
      log('[ProfileController] Error saving profile: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'ProfileController.saveProfile',
      );
      _error = 'Erro ao salvar perfil';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _userRepository.getUserProfile();
    } catch (e, stack) {
      log('[ProfileController] Error loading profile: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'ProfileController.loadProfile',
      );
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
      final ref = FirebaseService.storage.ref().child(
        'profile_images/$userId.jpg',
      );

      await ref.putFile(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      return await ref.getDownloadURL();
    } catch (e, stack) {
      log('[ProfileController] Error uploading image: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'ProfileController.uploadImage',
      );
      return null;
    }
  }

  Future<bool> updateProfile({
    required String displayName,
    String? phoneNumber,
    String? photoUrl,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedProfile = await _userRepository.updateProfileFields(
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
      );

      if (updatedProfile != null) {
        _profile = updatedProfile;
        return true;
      }

      _error = 'Erro ao atualizar perfil';
      return false;
    } catch (e, stack) {
      log('[ProfileController] Error updating profile: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'ProfileController.updateProfile',
      );
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
