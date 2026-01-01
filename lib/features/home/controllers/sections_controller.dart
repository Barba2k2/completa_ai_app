import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../core/network/api_client.dart';
import '../../../shared/models/section.dart';
import '../../../shared/services/section_api_service.dart';

class SectionsController extends ChangeNotifier {
  final SectionApiService _apiService;

  List<Section> _sections = [];
  bool _isLoading = false;
  String? _error;

  SectionsController(ApiClient apiClient)
      : _apiService = SectionApiService(apiClient);

  List<Section> get sections => _sections;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadSections() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _sections = await _apiService.getSections();
    } catch (e) {
      log('[SectionsController] Error loading: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Section? getSectionById(String id) {
    try {
      return _sections.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}
