import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../controllers/collection_controller.dart';

class StickerOptionsSheet extends StatelessWidget {
  const StickerOptionsSheet({
    super.key,
    required this.stickerId,
    required this.isOwned,
  });

  final String stickerId;
  final bool isOwned;

  static Future<void> show(
    BuildContext context, {
    required String stickerId,
    required bool isOwned,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => StickerOptionsSheet(
        stickerId: stickerId,
        isOwned: isOwned,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final collectionController = getIt<CollectionController>();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                isOwned
                    ? Icons.remove_circle_outline
                    : Icons.check_circle_outline,
              ),
              title:
                  Text(isOwned ? 'Remover da coleção' : 'Adicionar à coleção'),
              onTap: () {
                Navigator.pop(context);
                collectionController.toggleStickerOwned(stickerId);
              },
            ),
            if (isOwned) ...[
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text('Adicionar repetida'),
                onTap: () {
                  Navigator.pop(context);
                  collectionController.incrementRepeated(stickerId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle_outline),
                title: const Text('Remover repetida'),
                onTap: () {
                  Navigator.pop(context);
                  collectionController.decrementRepeated(stickerId);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
