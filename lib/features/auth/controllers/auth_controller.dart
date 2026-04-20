import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../shared/repositories/user_repository.dart';
import '../../../shared/services/firebase_service.dart';

class AuthController extends ChangeNotifier {
  final UserRepository _userRepository;

  bool _isLoading = false;
  String? _error;
  bool _isInitialized = false;
  bool _resetEmailSent = false;
  bool _splashCompleted = false;

  AuthController(this._userRepository);

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get resetEmailSent => _resetEmailSent;
  bool get splashCompleted => _splashCompleted;
  User? get currentUser => FirebaseService.currentUser;
  bool get isAuthenticated => currentUser != null;

  String getLoginErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('user-not-found')) {
      return 'Usuário não encontrado';
    }
    if (errorString.contains('wrong-password')) {
      return 'Senha incorreta';
    }
    if (errorString.contains('invalid-email')) {
      return 'E-mail inválido';
    }
    if (errorString.contains('user-disabled')) {
      return 'Conta desativada';
    }
    return 'Erro ao fazer login. Tente novamente';
  }

  String getRegisterErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('email-already-in-use')) {
      return 'Este e-mail já está em uso';
    }
    if (errorString.contains('invalid-email')) {
      return 'E-mail inválido';
    }
    if (errorString.contains('weak-password')) {
      return 'A senha é muito fraca';
    }
    return 'Erro ao criar conta. Tente novamente';
  }

  String getResetPasswordErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('user-not-found')) {
      return 'Usuário não encontrado';
    }
    if (errorString.contains('invalid-email')) {
      return 'E-mail inválido';
    }
    return 'Erro ao enviar e-mail. Tente novamente';
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearResetEmailSent() {
    _resetEmailSent = false;
    notifyListeners();
  }

  Future<void> checkInitialAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _splashCompleted = true;
    notifyListeners();
  }

  Stream<User?> get authStateChanges => FirebaseService.auth.authStateChanges();

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    await GoogleSignIn.instance.initialize();
    _isInitialized = true;
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _ensureInitialized();

      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      await FirebaseService.auth.signInWithCredential(credential);

      return true;
    } on GoogleSignInException catch (e, stack) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return false;
      }
      log('Google Sign-In error: ${e.code} - ${e.description}');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Google Sign-In',
      );
      _error = 'Erro ao fazer login com Google';
      return false;
    } catch (e, stack) {
      log('Google Sign-In error: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Google Sign-In',
      );
      _error = 'Erro ao fazer login com Google';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithApple() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final idToken = appleCredential.identityToken;
      if (idToken == null) {
        _error = 'Erro ao fazer login com Apple';
        return false;
      }

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: idToken,
        rawNonce: rawNonce,
      );

      await FirebaseService.auth.signInWithCredential(oauthCredential);

      return true;
    } on SignInWithAppleAuthorizationException catch (e, stack) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return false;
      }
      log('Apple Sign-In error: ${e.code} - ${e.message}');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Apple Sign-In',
      );
      _error = 'Erro ao fazer login com Apple';
      return false;
    } catch (e, stack) {
      log('Apple Sign-In error: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Apple Sign-In',
      );
      _error = 'Erro ao fazer login com Apple';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await FirebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } catch (e, stack) {
      log('Email Sign-In error: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Email Sign-In',
      );
      _error = getLoginErrorMessage(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createAccountWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final userCredential = await FirebaseService.auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      if (displayName != null && userCredential.user != null) {
        await userCredential.user!.updateDisplayName(displayName);
      }

      return true;
    } catch (e, stack) {
      log('Create Account error: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Create Account',
      );
      _error = getRegisterErrorMessage(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    _isLoading = true;
    _error = null;
    _resetEmailSent = false;
    notifyListeners();

    try {
      await FirebaseService.auth.sendPasswordResetEmail(email: email);
      _resetEmailSent = true;
      return true;
    } catch (e, stack) {
      log('Password Reset error: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Password Reset',
      );
      _error = getResetPasswordErrorMessage(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await _ensureInitialized();
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
    await FirebaseService.auth.signOut();
    notifyListeners();
  }

  Future<bool> deleteAccount() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = currentUser;
      if (user == null) {
        _error = 'Usuário não encontrado';
        return false;
      }

      final deleted = await _userRepository.deleteUserProfile();
      if (!deleted) {
        _error = 'Erro ao excluir dados do usuário';
        return false;
      }

      await user.delete();

      return true;
    } on FirebaseAuthException catch (e, stack) {
      log('Delete account error: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Delete Account',
      );
      if (e.code == 'requires-recent-login') {
        _error = 'Por favor, faça login novamente para excluir sua conta';
      } else {
        _error = 'Erro ao excluir conta. Tente novamente';
      }
      return false;
    } catch (e, stack) {
      log('Delete account error: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Delete Account',
      );
      _error = 'Erro ao excluir conta. Tente novamente';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
