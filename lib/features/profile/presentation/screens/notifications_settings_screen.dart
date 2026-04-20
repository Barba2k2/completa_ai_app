import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _newStickersNotification = true;
  bool _tradingNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          SwitchListTile(
            title: Text('Notificações', style: AppTextStyles.bodyMedium),
            subtitle: Text(
              'Ativar ou desativar todas as notificações',
              style: AppTextStyles.caption.copyWith(
                color: context.textSecondary,
              ),
            ),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
          ),
          const Divider(),
          SizedBox(height: 8.h),
          Text(
            'Tipos de notificação',
            style: AppTextStyles.labelLarge.copyWith(
              color: context.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          SwitchListTile(
            title: Text('Novas figurinhas', style: AppTextStyles.bodyMedium),
            subtitle: Text(
              'Receber alertas sobre novas figurinhas disponíveis',
              style: AppTextStyles.caption.copyWith(
                color: context.textSecondary,
              ),
            ),
            value: _newStickersNotification && _notificationsEnabled,
            onChanged: _notificationsEnabled
                ? (value) {
                    setState(() => _newStickersNotification = value);
                  }
                : null,
          ),
          SwitchListTile(
            title: Text('Trocas', style: AppTextStyles.bodyMedium),
            subtitle: Text(
              'Receber alertas sobre propostas de troca',
              style: AppTextStyles.caption.copyWith(
                color: context.textSecondary,
              ),
            ),
            value: _tradingNotification && _notificationsEnabled,
            onChanged: _notificationsEnabled
                ? (value) {
                    setState(() => _tradingNotification = value);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
