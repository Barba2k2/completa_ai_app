abstract final class AppRoutes {
  // Auth
  static const splash = '/';
  static const login = '/login';
  static const emailLogin = '/email-login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';

  // Main
  static const home = '/home';
  static const profile = '/profile';
  static const editProfile = '/edit-profile';
  static const themeSettings = '/theme-settings';
  static const notificationsSettings = '/notifications-settings';
  static const about = '/about';
  static const privacyPolicy = '/privacy-policy';
  static const termsOfUse = '/terms-of-use';

  // Collection
  static const collection = '/collection';
  static const section = '/collection/:sectionId';
  static const search = '/search';

  // Scanner
  static const scanner = '/scanner';

  // Share
  static const share = '/share';
}
