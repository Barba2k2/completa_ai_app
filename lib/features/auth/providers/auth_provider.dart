import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../shared/models/user_profile.dart';
import '../../../shared/repositories/user_repository.dart';
import '../../../shared/services/firebase_service.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseService.auth.authStateChanges();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (user) {
      if (user == null) return Stream.value(null);
      return ref.read(userRepositoryProvider).watchUserProfile(user.uid);
    },
    loading: () => Stream.value(null),
    error: (_, _) => Stream.value(null),
  );
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

class AuthService {
  final Ref _ref;
  bool _isInitialized = false;

  AuthService(this._ref);

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _ensureInitialized();

      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final userCredential =
          await FirebaseService.auth.signInWithCredential(credential);

      await _createOrUpdateUserProfile(userCredential.user);

      return userCredential;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      log('Google Sign-In error: ${e.code} - ${e.description}');
      rethrow;
    } catch (e) {
      log('Google Sign-In error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> signInWithApple() async {
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
        throw FirebaseAuthException(
          code: 'missing-apple-identity-token',
          message: 'Missing Apple identity token.',
        );
      }

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: idToken,
        rawNonce: rawNonce,
      );

      final userCredential =
          await FirebaseService.auth.signInWithCredential(oauthCredential);

      await _createOrUpdateUserProfile(userCredential.user);

      return userCredential;
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return null;
      }
      log('Apple Sign-In error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      log('Apple Sign-In error: $e');
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await FirebaseService.auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _createOrUpdateUserProfile(userCredential.user);

    return userCredential;
  }

  Future<UserCredential> createAccountWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final userCredential =
        await FirebaseService.auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (displayName != null && userCredential.user != null) {
      await userCredential.user!.updateDisplayName(displayName);
    }

    await _createOrUpdateUserProfile(userCredential.user);

    return userCredential;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseService.auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    try {
      await _ensureInitialized();
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
    await FirebaseService.auth.signOut();
  }

  Future<void> _createOrUpdateUserProfile(User? user) async {
    if (user == null) return;

    final repository = _ref.read(userRepositoryProvider);
    final existingProfile = await repository.getUserProfile(user.uid);

    if (existingProfile == null) {
      final newProfile = UserProfile(
        id: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
      await repository.createUserProfile(newProfile);
    } else {
      await repository.updateLoginWithProviderData(
        userId: user.uid,
        displayName: existingProfile.displayName ?? user.displayName,
        photoUrl: existingProfile.photoUrl ?? user.photoURL,
      );
    }
  }
}
