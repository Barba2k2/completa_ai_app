import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/api_client.dart';
import '../../../shared/models/sticker.dart';
import '../../../shared/services/sticker_api_service.dart';

class StickersController extends ChangeNotifier {
  final StickerApiService _apiService;

  final Map<String, List<Sticker>> _stickersBySection = {};
  final Set<String> _loadingSections = {};
  String? _error;

  StickersController(ApiClient apiClient)
      : _apiService = StickerApiService(apiClient);

  String? get error => _error;

  bool isLoadingSection(String sectionId) =>
      _loadingSections.contains(sectionId);

  List<Sticker> getStickersForSection(String sectionId) =>
      _stickersBySection[sectionId] ?? [];

  Future<void> loadStickersBySection(String sectionId) async {
    if (_loadingSections.contains(sectionId)) return;

    _loadingSections.add(sectionId);
    _error = null;
    notifyListeners();

    try {
      final stickers = await _apiService.getStickersBySection(sectionId);
      _stickersBySection[sectionId] = stickers;
    } catch (e, stack) {
      log('[StickersController] Error loading section $sectionId: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'StickersController.loadStickersBySection',
      );
      _error = e.toString();
    } finally {
      _loadingSections.remove(sectionId);
      notifyListeners();
    }
  }

  Future<List<Sticker>> searchStickers(String query) async {
    try {
      return await _apiService.searchStickers(query);
    } catch (e, stack) {
      log('[StickersController] Error searching: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'StickersController.searchStickers',
      );
      return [];
    }
  }
}
