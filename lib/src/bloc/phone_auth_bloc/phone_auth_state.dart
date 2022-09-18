part of 'phone_auth_bloc.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object?> get props => [];
}

class PhoneAuthInitalState extends PhoneAuthState {}

class PhoneAuthLoadingState extends PhoneAuthState {}

class PhoneAuthErrorState extends PhoneAuthState {
  final String msg;
  const PhoneAuthErrorState(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

// all possible states during OTP verification.
class PhoneAuthSMSCodeReceivedState extends PhoneAuthState {
  final int? token;
  final String verificationId;

  const PhoneAuthSMSCodeReceivedState(this.token, this.verificationId);

  @override
  List<Object?> get props => [token, verificationId];
}

class PhoneAuthCompletedState extends PhoneAuthState {
  // final String uid;
  // final String phoneno;

  // const PhoneAuthCompletedState(this.uid, this.phoneno);

  // @override
  // List<Object?> get props => [uid, phoneno];
}

class PhoneAuthCodeAutoRetrevalTimeoutCompleteState extends PhoneAuthState {
  final String verificationId;

  const PhoneAuthCodeAutoRetrevalTimeoutCompleteState(this.verificationId);
  @override
  List<Object?> get props => [verificationId];
}
