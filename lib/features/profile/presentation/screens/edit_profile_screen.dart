import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _profileController = getIt<ProfileController>();

  @override
  void initState() {
    super.initState();
    _profileController.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: ListenableBuilder(
        listenable: _profileController,
        builder: (context, _) {
          if (_profileController.profileSaved) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.showSnackBar('Perfil atualizado com sucesso');
              _profileController.clearProfileSaved();
              context.pop();
            });
          }

          if (_profileController.error != null &&
              _profileController.profile != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.showSnackBar(_profileController.error!, isError: true);
              _profileController.clearError();
            });
          }

          if (_profileController.isLoading &&
              _profileController.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_profileController.error != null &&
              _profileController.profile == null) {
            return Center(
              child: Text(
                'Erro ao carregar perfil',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.textSecondary,
                ),
              ),
            );
          }

          return EditProfileForm(profile: _profileController.profile);
        },
      ),
    );
  }
}
