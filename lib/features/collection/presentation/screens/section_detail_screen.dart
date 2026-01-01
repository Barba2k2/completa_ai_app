import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/providers/sections_provider.dart';
import '../../providers/stickers_provider.dart';
import '../widgets/sticker_grid_item.dart';
import '../widgets/sticker_options_sheet.dart';

class SectionDetailScreen extends ConsumerWidget {
  const SectionDetailScreen({
    super.key,
    required this.sectionId,
  });

  final String sectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionAsync = ref.watch(sectionByIdProvider(sectionId));
    final stickersAsync = ref.watch(stickersBySectionProvider(sectionId));
    final userStickersAsync = ref.watch(userStickersProvider);

    return Scaffold(
      appBar: AppBar(
        title: sectionAsync.when(
          data: (section) => Text(section?.name ?? 'Seção'),
          loading: () => const Text('Carregando...'),
          error: (_, _) => const Text('Erro'),
        ),
      ),
      body: stickersAsync.when(
        data: (stickers) {
          if (stickers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.collections_bookmark_outlined,
                    size: 64.w,
                    color: context.textTertiary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Nenhuma figurinha encontrada',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: context.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          final userStickers = userStickersAsync.value ?? {};

          return GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.w,
              childAspectRatio: 0.85,
            ),
            itemCount: stickers.length,
            itemBuilder: (context, index) {
              final sticker = stickers[index];
              final userSticker = userStickers[sticker.id];
              final isOwned = userSticker?.isOwned ?? false;
              final repeatedCount = userSticker?.repeatedCount ?? 0;

              return StickerGridItem(
                number: sticker.number,
                name: sticker.name,
                isOwned: isOwned,
                repeatedCount: repeatedCount,
                onTap: () => ref
                    .read(stickerServiceProvider)
                    .toggleStickerOwned(sticker.id),
                onLongPress: () => StickerOptionsSheet.show(
                  context,
                  stickerId: sticker.id,
                  isOwned: isOwned,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 48.w,
                color: context.colorScheme.error,
              ),
              SizedBox(height: 16.h),
              Text(
                'Erro ao carregar figurinhas',
                style: AppTextStyles.bodyMedium,
              ),
              SizedBox(height: 8.h),
              TextButton(
                onPressed: () =>
                    ref.invalidate(stickersBySectionProvider(sectionId)),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
