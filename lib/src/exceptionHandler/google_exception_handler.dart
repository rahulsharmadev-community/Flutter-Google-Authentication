class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure(
            'Unknown An exception occurred. Try again later.');
    }
  }

  /// The associated error message.
  final String message;
}

class SignInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const SignInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure(
            'Unknown An exception occurred. Try again later.');
    }
  }

  /// The associated error message.
  final String message;
}

class SignInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const SignInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const SignInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const SignInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const SignInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const SignInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const SignInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const SignInWithGoogleFailure(
            'Unknown An exception occurred. Try again later.');
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class SignOutFailure implements Exception {}

/// Thrown during the send email verification process if a failure occurs.
class SendEmailVerificationFailure implements Exception {
  final String message;
  const SendEmailVerificationFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SendEmailVerificationFailure.fromCode(String code) {
    switch (code) {
      case 'null-credential':
        return const SendEmailVerificationFailure(
            'User Credential Is Not Available Please relaunch the application.');
      default:
        return const SendEmailVerificationFailure();
    }
  }
}

/// Thrown during the forget password process if a failure occurs.
class ForgetPasswordFailure implements Exception {
  final String message;
  const ForgetPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory ForgetPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const ForgetPasswordFailure(
            'Incorrect email address Please Enter a Valid Email Address.');
      case 'missing-android-pkg-name':
        return const ForgetPasswordFailure(
            'App is Corrupted; Please consider installing the app again.');
      case 'user-not-found':
        return const ForgetPasswordFailure(
            'There is no user corresponding to the email address.');
      default:
        return const ForgetPasswordFailure(
            'Unknown An exception occurred. Try again later.');
    }
  }
}

/// Thrown during the change password process if a failure occurs.
class ChangePasswordFailure implements Exception {
  final String message;
  const ChangePasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory ChangePasswordFailure.fromCode(String code) {
    switch (code) {
      case 'weak-password':
        return const ChangePasswordFailure('Password is not strong enough.');
      case 'requires-recent-login':
        return const ChangePasswordFailure(
            'User is seems anonymous, Please contect to support team.');
      default:
        return const ChangePasswordFailure(
            'Unknown An exception occurred. Try again later.');
    }
  }
}
