import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/user_profile.dart';
import '../../../../shared/services/firebase_service.dart';
import '../../../auth/providers/auth_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  File? _selectedImage;
  String? _currentPhotoUrl;
  bool _isLoading = false;
  bool _isInitialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _initializeFields(UserProfile? profile) {
    if (_isInitialized || profile == null) return;

    _nameController.text = profile.displayName ?? '';
    _phoneController.text = profile.phoneNumber ?? '';
    _currentPhotoUrl = profile.photoUrl;
    _isInitialized = true;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(String userId) async {
    if (_selectedImage == null) return _currentPhotoUrl;

    try {
      final ref = FirebaseService.storage.ref().child('profile_images/$userId.jpg');

      await ref.putFile(
        _selectedImage!,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      return await ref.getDownloadURL();
    } catch (e) {
      log('Error uploading image: $e');
      return _currentPhotoUrl;
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final userId = FirebaseService.currentUserId;
    if (userId == null) return;

    setState(() => _isLoading = true);

    try {
      final photoUrl = await _uploadImage(userId);

      await ref.read(userRepositoryProvider).updateProfileFields(
            userId: userId,
            displayName: _nameController.text.trim(),
            phoneNumber: _phoneController.text.trim().isEmpty
                ? null
                : _phoneController.text.trim(),
            photoUrl: photoUrl,
          );

      if (mounted) {
        context.showSnackBar('Perfil atualizado com sucesso');
        context.pop();
      }
    } catch (e) {
      log('Error saving profile: $e');
      if (mounted) {
        context.showSnackBar('Erro ao salvar perfil', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: _isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'Salvar',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: userProfileAsync.when(
        data: (profile) {
          _initializeFields(profile);
          return _buildForm(context);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Text(
            'Erro ao carregar perfil',
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 56.r,
                    backgroundColor: context.surfaceVariant,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : _currentPhotoUrl != null
                            ? NetworkImage(_currentPhotoUrl!)
                            : null,
                    child: _selectedImage == null && _currentPhotoUrl == null
                        ? Icon(
                            Icons.person_rounded,
                            size: 56.w,
                            color: context.textSecondary,
                          )
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.theme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 20.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              'Toque para alterar a foto',
              style: AppTextStyles.caption.copyWith(
                color: context.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Text('Nome', style: AppTextStyles.labelMedium),
          SizedBox(height: 8.h),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Digite seu nome',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nome é obrigatório';
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          Text('Telefone', style: AppTextStyles.labelMedium),
          SizedBox(height: 8.h),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              hintText: '(00) 00000-0000',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
