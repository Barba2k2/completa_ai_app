import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/user_profile.dart';
import '../../controllers/profile_controller.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    super.key,
    required this.profile,
  });

  final UserProfile? profile;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _profileController = getIt<ProfileController>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.profile?.displayName ?? '';
    _phoneController.text = widget.profile?.phoneNumber ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _profileController,
      builder: (context, _) {
        final selectedImage = _profileController.selectedImage;
        final isLoading = _profileController.isLoading;

        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(24.w),
            children: [
              Center(
                child: GestureDetector(
                  onTap: isLoading ? null : _profileController.pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 56.r,
                        backgroundColor: context.surfaceVariant,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage)
                            : widget.profile?.photoUrl != null
                            ? NetworkImage(widget.profile!.photoUrl!)
                            : null,
                        child:
                            selectedImage == null &&
                                widget.profile?.photoUrl == null
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
              Text(
                'Nome',
                style: AppTextStyles.labelMedium,
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _nameController,
                enabled: !isLoading,
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
              Text(
                'Telefone',
                style: AppTextStyles.labelMedium,
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _phoneController,
                enabled: !isLoading,
                decoration: const InputDecoration(
                  hintText: '(00) 00000-0000',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 32.h),
              FilledButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _profileController.saveProfile(
                            displayName: _nameController.text.trim(),
                            phoneNumber: _phoneController.text.trim().isEmpty
                                ? null
                                : _phoneController.text.trim(),
                          );
                        }
                      },
                child: isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Salvar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
