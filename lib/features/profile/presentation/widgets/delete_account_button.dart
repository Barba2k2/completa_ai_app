import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../../auth/controllers/auth_controller.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _handleDeleteAccount(context),
      icon: Icon(
        Icons.delete_forever_rounded,
        color: context.colorScheme.error,
      ),
      label: Text(
        'Excluir conta',
        style: AppTextStyles.labelLarge.copyWith(
          color: context.colorScheme.error,
        ),
      ),
    );
  }

  Future<void> _handleDeleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir conta'),
        content: const Text(
          'Tem certeza que deseja excluir sua conta?\n\n'
          'Esta ação é irreversível e todos os seus dados serão perdidos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final authController = getIt<AuthController>();
    final success = await authController.deleteAccount();

    if (!context.mounted) return;

    if (success) {
      context.go(AppRoutes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authController.error ?? 'Erro ao excluir conta'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}
