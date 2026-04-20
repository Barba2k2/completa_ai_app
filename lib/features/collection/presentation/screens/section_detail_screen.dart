import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../controllers/section_detail_controller.dart';
import '../widgets/sticker_grid_item.dart';
import '../widgets/sticker_options_sheet.dart';

class SectionDetailScreen extends StatefulWidget {
  const SectionDetailScreen({
    super.key,
    required this.sectionId,
  });

  final String sectionId;

  @override
  State<SectionDetailScreen> createState() => _SectionDetailScreenState();
}

class _SectionDetailScreenState extends State<SectionDetailScreen> {
  final _controller = getIt<SectionDetailController>();

  @override
  void initState() {
    super.initState();
    _controller.loadStickers(widget.sectionId);
  }

  @override
  Widget build(BuildContext context) {
    final section = _controller.sections.getSectionById(widget.sectionId);

    return Scaffold(
      appBar: AppBar(
        title: Text(section?.name ?? 'Seção'),
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          if (_controller.stickers.isLoadingSection(widget.sectionId)) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.stickers.error != null) {
            return Center(
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
                        _controller.loadStickers(widget.sectionId),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          final stickers =
              _controller.stickers.getStickersForSection(widget.sectionId);

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
              final quantity = _controller.collection.getQuantity(sticker.id);
              final isOwned = quantity > 0;
              final repeatedCount = quantity > 1 ? quantity - 1 : 0;

              return StickerGridItem(
                number: sticker.number,
                name: sticker.name,
                isOwned: isOwned,
                repeatedCount: repeatedCount,
                onTap: () =>
                    _controller.collection.toggleStickerOwned(sticker.id),
                onLongPress: () => StickerOptionsSheet.show(
                  context,
                  stickerId: sticker.id,
                  isOwned: isOwned,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
