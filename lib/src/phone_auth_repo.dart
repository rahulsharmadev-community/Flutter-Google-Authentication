import 'package:config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneNoAuthRepository {
  /// {@macro authentication_repository}
  PhoneNoAuthRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  /// For Native (e.g. Android & iOS)
  Future<void> verifyPhoneNumber(
      {required String mobileNumber,
      required void Function(PhoneAuthCredential) onVerificationCompleted,
      required void Function(FirebaseAuthException error) onVerificaitonFailed,
      required void Function(String verificationId, int? forceResendingToken)
          onCodeSent,
      required void Function(String verificationId) onCodeAutoRetrievalTimeOut,
      int? forceResendingToken}) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        verificationCompleted: (p0) async {
          printLog('Run Befor Type', logType: LogType.warning);
          // ANDROID ONLY!
          // Sign the user in (or link) with the auto-generated credential
          await _firebaseAuth.signInWithCredential(p0);
          return onVerificationCompleted(p0);
        },
        verificationFailed: onVerificaitonFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeOut,
        timeout: const Duration(seconds: 60),
        forceResendingToken: forceResendingToken);
  }

  Future<void> verifySMSCode({
    required String smsCode,
    required String verificationId,
  }) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _firebaseAuth.signInWithCredential(phoneAuthCredential);
  }

  late ConfirmationResult _confirmationResult;
  // Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
  Future<MapEntry<String, int>> signInWithPhoneNumberForWeb(
      {required String mobileNumber}) async {
    _confirmationResult =
        await _firebaseAuth.signInWithPhoneNumber(mobileNumber);
    return MapEntry<String, int>(
      _confirmationResult.verificationId,
      _confirmationResult.hashCode,
    );
  }

  Future<void> verifySMSCodeForWeb({required String smsCode}) async {
    await _confirmationResult.confirm(smsCode);
  }
}
