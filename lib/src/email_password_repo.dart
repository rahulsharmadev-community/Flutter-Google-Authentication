import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'exceptionHandler/google_exception_handler.dart';

class EmailPasswordAuthRepository {
  EmailPasswordAuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> createUser(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [SignInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithEmailAndPasswordFailure();
    }
  }

  /// Only when the user is sign-in they change their password.
  ///
  /// Throws a [ChangePasswordFailure] if an exception occurs.
  Future<void> changePassword({
    required String password,
  }) async {
    try {
      await _firebaseAuth.currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      throw ChangePasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const ChangePasswordFailure();
    }
  }

  /// Send email to the user,
  ///
  /// Throws a [SendEmailVerificationFailure] if an exception occurs.
  Future<void> sendEmailVerificationLink() async {
    try {
      if (_firebaseAuth.currentUser == null &&
          _firebaseAuth.currentUser!.email == null) {
        throw const SendEmailVerificationFailure('null-credential');
      } else {
        await _firebaseAuth.currentUser!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw SendEmailVerificationFailure.fromCode(e.code);
    } catch (_) {
      throw const SendEmailVerificationFailure();
    }
  }

  /// Forget Password by using email.
  ///
  /// Throws a [ForgetPasswordFailure] if an exception occurs.
  Future<void> forgetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ForgetPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const ForgetPasswordFailure();
    }
  }
}
