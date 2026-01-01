import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  Future<void> logSignUp(String method) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> setUserId(String? userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  Future<void> logStickerScanned(String stickerId) async {
    await logEvent(
      name: 'sticker_scanned',
      parameters: {'sticker_id': stickerId},
    );
  }

  Future<void> logStickerAdded(String stickerId, String sectionId) async {
    await logEvent(
      name: 'sticker_added',
      parameters: {'sticker_id': stickerId, 'section_id': sectionId},
    );
  }

  Future<void> logCollectionProgress(int total, int collected) async {
    await logEvent(
      name: 'collection_progress',
      parameters: {
        'total': total,
        'collected': collected,
        'percentage': total > 0 ? (collected / total * 100).round() : 0,
      },
    );
  }
}
