import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../collection/providers/stickers_provider.dart';
import '../../providers/sections_provider.dart';
import '../widgets/progress_card.dart';
import '../widgets/section_list_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsAsync = ref.watch(sectionsProvider);
    final userStickersAsync = ref.watch(userStickersProvider);
    final userProfileAsync = ref.watch(userProfileProvider);

    final userStickers = userStickersAsync.value ?? {};
    final ownedCount = userStickers.values.where((s) => s.isOwned).length;
    final repeatedCount = userStickers.values
        .fold<int>(0, (sum, s) => sum + s.repeatedCount);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: userProfileAsync.when(
              data: (profile) {
                if (profile?.photoUrl != null) {
                  return CircleAvatar(
                    radius: 14.r,
                    backgroundImage: NetworkImage(profile!.photoUrl!),
                  );
                }
                return const Icon(Icons.person_outline_rounded);
              },
              loading: () => const Icon(Icons.person_outline_rounded),
              error: (_, _) => const Icon(Icons.person_outline_rounded),
            ),
            onPressed: () => context.push(AppRoutes.profile),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(sectionsProvider);
          ref.invalidate(userStickersProvider);
        },
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            ProgressCard(
              collected: ownedCount,
              total: AppConstants.totalStickers,
              repeated: repeatedCount,
            ),
            SizedBox(height: 24.h),
            Text(
              'Seções',
              style: AppTextStyles.h4,
            ),
            SizedBox(height: 12.h),
            sectionsAsync.when(
              data: (sections) {
                if (sections.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Column(
                        children: [
                          Icon(
                            Icons.folder_outlined,
                            size: 48.w,
                            color: context.textTertiary,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Nenhuma seção encontrada',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: context.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: sections.map((section) {
                    final sectionStickersOwned = userStickers.entries
                        .where((e) => e.value.isOwned)
                        .length;

                    return SectionListItem(
                      title: section.name,
                      code: section.id.substring(0, 3).toUpperCase(),
                      collected: sectionStickersOwned,
                      total: section.totalStickers,
                      onTap: () => context.push(
                        AppRoutes.section.replaceFirst(':sectionId', section.id),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: const CircularProgressIndicator(),
                ),
              ),
              error: (error, _) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 48.w,
                        color: context.colorScheme.error,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Erro ao carregar seções',
                        style: AppTextStyles.bodyMedium,
                      ),
                      SizedBox(height: 8.h),
                      TextButton(
                        onPressed: () => ref.invalidate(sectionsProvider),
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.scanner),
        icon: const Icon(Icons.qr_code_scanner_rounded),
        label: const Text('Scanner'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
