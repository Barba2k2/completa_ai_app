import 'package:flutter/foundation.dart';

import '../../../core/di/app_dependencies.dart';
import '../../collection/controllers/collection_controller.dart';
import 'sections_controller.dart';

class HomeController extends ChangeNotifier {
  final SectionsController _sectionsController;
  final CollectionController _collectionController;

  HomeController()
      : _sectionsController = getIt<SectionsController>(),
        _collectionController = getIt<CollectionController>() {
    _sectionsController.addListener(notifyListeners);
    _collectionController.addListener(notifyListeners);
  }

  SectionsController get sections => _sectionsController;
  CollectionController get collection => _collectionController;

  bool get isLoading =>
      _sectionsController.isLoading || _collectionController.isLoading;

  Future<void> loadData() async {
    await Future.wait([
      _sectionsController.loadSections(),
      _collectionController.loadCollection(),
    ]);
  }

  @override
  void dispose() {
    _sectionsController.removeListener(notifyListeners);
    _collectionController.removeListener(notifyListeners);
    super.dispose();
  }
}
