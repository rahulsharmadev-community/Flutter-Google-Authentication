import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'exceptionHandler/google_exception_handler.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class GoogleAuthRepository {
  /// {@macro authentication_repository}
  GoogleAuthRepository({
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [SignInWithGoogleFailure] if an exception occurs.
  Future<void> signInWithGoogle() async {
    try {
      late final AuthCredential credential;
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SignInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithGoogleFailure();
    }
  }

// ___________________________________________________________________________________________________________
  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  // Future<void> logOut() async {
  //   try {
  //     await Future.wait([
  //       _firebaseAuth.signOut(),
  //       _googleSignIn.signOut(),
  //     ]);
  //   } catch (_) {
  //     throw LogOutFailure();
  //   }
  // }
}
// ___________________________________________________________________________________________________________

