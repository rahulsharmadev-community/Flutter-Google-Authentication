import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:authentication/src/phone_auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final PhoneNoAuthRepository _phoneNoAuthRepository;
  PhoneAuthBloc()
      : _phoneNoAuthRepository = PhoneNoAuthRepository(),
        super(PhoneAuthInitalState()) {
    on<PhoneAuthVerifyNumber>((event, emit) async {
      emit(PhoneAuthLoadingState());
      if (!emit.isDone) await _onVerifyPhoneNumber(event.phoneNumber, emit);
    });

    on<PhoneAuthOTPCodeResend>((event, emit) async {
      emit(PhoneAuthLoadingState());
      await _onVerifyPhoneNumber(event.phoneNumber, emit,
          forceResendingToken: event.token);
    });
    on<PhoneAuthVerifyOTPCode>(_onVerifyOTPCode);
  }

  Future<void> _onVerifyPhoneNumber(
      String phoneNumber, Emitter<PhoneAuthState> emit,
      {int? forceResendingToken}) async {
    Completer<PhoneAuthState> c = Completer<PhoneAuthState>();
    if (kIsWeb) {
      final _data = await _phoneNoAuthRepository.signInWithPhoneNumberForWeb(
          mobileNumber: phoneNumber);
      emit(PhoneAuthSMSCodeReceivedState(_data.value, _data.key));
    } else {
      await _phoneNoAuthRepository.verifyPhoneNumber(
          mobileNumber: phoneNumber,
          onCodeAutoRetrievalTimeOut: (String verificationId) async {
            c.complete(
                PhoneAuthCodeAutoRetrevalTimeoutCompleteState(verificationId));
            Future.delayed(const Duration(milliseconds: 30))
                .whenComplete(() => c.complete(PhoneAuthInitalState()));
          },
          onCodeSent: (String verificationId, int? forceResendingToken) {
            c.complete(PhoneAuthSMSCodeReceivedState(
                forceResendingToken, verificationId));
          },
          onVerificaitonFailed: (FirebaseAuthException error) {
            c.complete(PhoneAuthErrorState(
                error.message ?? 'Unknown exception occered'));
          },
          onVerificationCompleted: ((p0) =>
              c.complete(PhoneAuthCompletedState())),
          forceResendingToken: forceResendingToken);
    }
    emit(await c.future);
  }

  FutureOr<void> _onVerifyOTPCode(PhoneAuthVerifyOTPCode event, emit) async {
    Completer<PhoneAuthState> c = Completer<PhoneAuthState>();
    emit(PhoneAuthLoadingState());
    if (kIsWeb) {
      try {
        await _phoneNoAuthRepository.verifySMSCodeForWeb(
            smsCode: event.smsCode);
        c.complete(PhoneAuthCompletedState());
      } on FirebaseAuthException catch (error) {
        c.complete(
            PhoneAuthErrorState(error.message ?? 'Unknown error occured'));
      }
    } else {
      await _phoneNoAuthRepository.verifySMSCode(
          smsCode: event.smsCode, verificationId: event.verificationId);
      c.complete(PhoneAuthCompletedState());
    }
    emit(await c.future);
  }
}
