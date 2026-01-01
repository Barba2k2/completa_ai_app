import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../core/network/api_client.dart';
import '../../../shared/models/user_sticker.dart';
import '../../../shared/services/collection_api_service.dart';

class CollectionController extends ChangeNotifier {
  final CollectionApiService _apiService;

  Map<String, UserSticker> _stickers = {};
  bool _isLoading = false;
  bool _isSyncing = false;
  String? _error;
  DateTime? _lastSyncedAt;

  CollectionController(ApiClient apiClient)
      : _apiService = CollectionApiService(apiClient);

  Map<String, UserSticker> get stickers => _stickers;
  bool get isLoading => _isLoading;
  bool get isSyncing => _isSyncing;
  String? get error => _error;
  DateTime? get lastSyncedAt => _lastSyncedAt;

  int get totalOwned => _stickers.values.where((s) => s.isOwned).length;
  int get totalRepeated =>
      _stickers.values.fold(0, (sum, s) => sum + s.repeatedCount);

  int getQuantity(String stickerId) {
    final sticker = _stickers[stickerId];
    if (sticker == null || !sticker.isOwned) return 0;
    return 1 + sticker.repeatedCount;
  }

  Future<void> loadCollection() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _stickers = await _apiService.getCollection();
      _lastSyncedAt = DateTime.now();
    } catch (e) {
      log('[CollectionController] Error loading: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> syncCollection() async {
    if (_isSyncing) return;

    _isSyncing = true;
    _error = null;
    notifyListeners();

    try {
      _stickers = await _apiService.syncCollection(
        stickers: _toApiFormat(),
        clientTime: DateTime.now(),
      );
      _lastSyncedAt = DateTime.now();
    } catch (e) {
      log('[CollectionController] Error syncing: $e');
      _error = e.toString();
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  Future<void> toggleStickerOwned(String stickerId) async {
    final current = _stickers[stickerId];
    final isCurrentlyOwned = current?.isOwned ?? false;

    _stickers[stickerId] = UserSticker(
      stickerId: stickerId,
      isOwned: !isCurrentlyOwned,
      repeatedCount: !isCurrentlyOwned ? 0 : (current?.repeatedCount ?? 0),
      updatedAt: DateTime.now(),
    );
    notifyListeners();

    await _saveToApi();
  }

  Future<void> incrementRepeated(String stickerId) async {
    final current = _stickers[stickerId];
    final currentCount = current?.repeatedCount ?? 0;

    _stickers[stickerId] = UserSticker(
      stickerId: stickerId,
      isOwned: true,
      repeatedCount: currentCount + 1,
      updatedAt: DateTime.now(),
    );
    notifyListeners();

    await _saveToApi();
  }

  Future<void> decrementRepeated(String stickerId) async {
    final current = _stickers[stickerId];
    if (current == null || current.repeatedCount <= 0) return;

    _stickers[stickerId] = current.copyWith(
      repeatedCount: current.repeatedCount - 1,
      updatedAt: DateTime.now(),
    );
    notifyListeners();

    await _saveToApi();
  }

  Future<void> setQuantity(String stickerId, int quantity) async {
    if (quantity < 0) return;

    _stickers[stickerId] = UserSticker(
      stickerId: stickerId,
      isOwned: quantity > 0,
      repeatedCount: quantity > 1 ? quantity - 1 : 0,
      updatedAt: DateTime.now(),
    );
    notifyListeners();

    await _saveToApi();
  }

  Map<String, int> _toApiFormat() {
    final result = <String, int>{};
    for (final entry in _stickers.entries) {
      if (entry.value.isOwned) {
        result[entry.key] = 1 + entry.value.repeatedCount;
      }
    }
    return result;
  }

  Future<void> _saveToApi() async {
    try {
      await _apiService.updateCollection(_toApiFormat());
    } catch (e) {
      log('[CollectionController] Error saving: $e');
    }
  }
}
