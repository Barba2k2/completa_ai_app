import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../controllers/home_controller.dart';
import 'section_list_item.dart';

class SectionsList extends StatelessWidget {
  const SectionsList({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.sections.isLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: const CircularProgressIndicator(),
        ),
      );
    }

    if (controller.sections.error != null) {
      return Center(
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
              Text('Erro ao carregar seções', style: AppTextStyles.bodyMedium),
              SizedBox(height: 8.h),
              TextButton(
                onPressed: controller.sections.loadSections,
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    final sections = controller.sections.sections;

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
        return SectionListItem(
          title: section.name,
          code: section.id.substring(0, 3).toUpperCase(),
          collected: controller.collection.totalOwned,
          total: section.totalStickers,
          onTap: () => context.push(
            AppRoutes.section.replaceFirst(':sectionId', section.id),
          ),
        );
      }).toList(),
    );
  }
}
