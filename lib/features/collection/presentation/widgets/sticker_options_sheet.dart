import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../providers/stickers_provider.dart';

class StickerOptionsSheet extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
                ref.read(stickerServiceProvider).toggleStickerOwned(stickerId);
              },
            ),
            if (isOwned) ...[
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text('Adicionar repetida'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(stickerServiceProvider).incrementRepeated(stickerId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle_outline),
                title: const Text('Remover repetida'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(stickerServiceProvider).decrementRepeated(stickerId);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
