import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../collection/providers/stickers_provider.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_header_error.dart';
import '../widgets/profile_header_loading.dart';
import '../widgets/profile_stats_card.dart';
import '../widgets/settings_list_item.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);
    final userStickersAsync = ref.watch(userStickersProvider);

    final userStickers = userStickersAsync.value ?? {};
    final ownedCount = userStickers.values.where((s) => s.isOwned).length;
    final repeatedCount =
        userStickers.values.fold<int>(0, (sum, s) => sum + s.repeatedCount);
    final progress = AppConstants.totalStickers > 0
        ? (ownedCount / AppConstants.totalStickers * 100).toStringAsFixed(1)
        : '0.0';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          userProfileAsync.when(
            data: (profile) => ProfileHeader(profile: profile),
            loading: () => const ProfileHeaderLoading(),
            error: (_, _) => const ProfileHeaderError(),
          ),
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
        ],
      ),
    );
  }
}
