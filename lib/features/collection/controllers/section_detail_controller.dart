import 'package:flutter/foundation.dart';

import '../../../core/di/app_dependencies.dart';
import '../../home/controllers/sections_controller.dart';
import 'collection_controller.dart';
import 'stickers_controller.dart';

class SectionDetailController extends ChangeNotifier {
  final SectionsController _sectionsController;
  final StickersController _stickersController;
  final CollectionController _collectionController;

  SectionDetailController()
      : _sectionsController = getIt<SectionsController>(),
        _stickersController = getIt<StickersController>(),
        _collectionController = getIt<CollectionController>() {
    _stickersController.addListener(notifyListeners);
    _collectionController.addListener(notifyListeners);
  }

  SectionsController get sections => _sectionsController;
  StickersController get stickers => _stickersController;
  CollectionController get collection => _collectionController;

  Future<void> loadStickers(String sectionId) =>
      _stickersController.loadStickersBySection(sectionId);

  @override
  void dispose() {
    _stickersController.removeListener(notifyListeners);
    _collectionController.removeListener(notifyListeners);
    super.dispose();
  }
}
