import 'package:flutter/foundation.dart';

import '../../../core/di/app_dependencies.dart';
import '../../collection/controllers/collection_controller.dart';
import 'profile_controller.dart';

class ProfileScreenController extends ChangeNotifier {
  final ProfileController _profileController;
  final CollectionController _collectionController;

  ProfileScreenController()
      : _profileController = getIt<ProfileController>(),
        _collectionController = getIt<CollectionController>() {
    _profileController.addListener(notifyListeners);
    _collectionController.addListener(notifyListeners);
  }

  ProfileController get profile => _profileController;
  CollectionController get collection => _collectionController;

  Future<void> loadProfile() => _profileController.loadProfile();

  @override
  void dispose() {
    _profileController.removeListener(notifyListeners);
    _collectionController.removeListener(notifyListeners);
    super.dispose();
  }
}
