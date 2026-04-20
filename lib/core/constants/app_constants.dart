abstract final class AppConstants {
  // App Info
  static const appName = 'Completa Aí';
  static const appVersion = '1.0.0';

  // Design
  static const designWidth = 390.0;
  static const designHeight = 844.0;

  // Album Info
  static const totalStickers = 980;
  static const stickersPerTeam = 20;
  static const totalTeams = 48;
  static const playersPerTeam = 18;

  // Scanner
  static const scannerCooldownMs = 2000;
  static const stickerCodePattern = r'[A-Z]{2,3}\s?\d{1,2}';

  // Storage Keys
  static const storageKeyCollection = 'user_collection';
  static const storageKeyLastSync = 'last_sync';
  static const storageKeyOnboarding = 'onboarding_completed';
}
