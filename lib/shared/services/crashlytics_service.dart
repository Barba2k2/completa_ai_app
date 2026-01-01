import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  Future<void> setUserId(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  Future<void> setCustomKey(String key, Object value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(exception, stack, fatal: fatal);
  }

  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    await _crashlytics.recordFlutterFatalError(details);
  }
}
