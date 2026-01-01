import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/app_dependencies.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../controllers/profile_screen_controller.dart';
import '../widgets/delete_account_button.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_header_error.dart';
import '../widgets/profile_header_loading.dart';
import '../widgets/profile_stats_card.dart';
import '../widgets/settings_list_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = getIt<ProfileScreenController>();

  @override
  void initState() {
    super.initState();
    _controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final ownedCount = _controller.collection.totalOwned;
          final repeatedCount = _controller.collection.totalRepeated;
          final progress = AppConstants.totalStickers > 0
              ? (ownedCount / AppConstants.totalStickers * 100).toStringAsFixed(
                  1,
                )
              : '0.0';

          Widget profileHeader;
          if (_controller.profile.isLoading) {
            profileHeader = const ProfileHeaderLoading();
          } else if (_controller.profile.error != null) {
            profileHeader = const ProfileHeaderError();
          } else {
            profileHeader = ProfileHeader(
              profile: _controller.profile.profile,
            );
          }

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              profileHeader,
              SizedBox(height: 24.h),
              ProfileStatsCard(
                ownedCount: ownedCount,
                repeatedCount: repeatedCount,
                progress: progress,
              ),
              SizedBox(height: 24.h),
              Text(
                'Configurações',
                style: AppTextStyles.h4,
              ),
              SizedBox(height: 12.h),
              SettingsListItem(
                icon: Icons.palette_outlined,
                title: 'Tema',
                subtitle: 'Automático',
                onTap: () => context.push(AppRoutes.themeSettings),
              ),
              SettingsListItem(
                icon: Icons.notifications_outlined,
                title: 'Notificações',
                subtitle: 'Ativadas',
                onTap: () => context.push(AppRoutes.notificationsSettings),
              ),
              SettingsListItem(
                icon: Icons.info_outline_rounded,
                title: 'Sobre o app',
                subtitle: 'Versão ${AppConstants.appVersion}',
                onTap: () => context.push(AppRoutes.about),
              ),
              SizedBox(height: 24.h),
              const LogoutButton(),
              SizedBox(height: 8.h),
              const DeleteAccountButton(),
            ],
          );
        },
      ),
    );
  }
}
