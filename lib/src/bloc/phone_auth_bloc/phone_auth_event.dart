part of 'phone_auth_bloc.dart';

@immutable
abstract class PhoneAuthEvent extends Equatable {}

class PhoneAuthSignOutEvent extends PhoneAuthEvent {
  PhoneAuthSignOutEvent();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PhoneAuthVerifyNumber extends PhoneAuthEvent {
  final String phoneNumber;

  PhoneAuthVerifyNumber({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneAuthVerifyOTPCode extends PhoneAuthEvent {
  final String smsCode;
  final String verificationId;

  PhoneAuthVerifyOTPCode({required this.smsCode, required this.verificationId});

  @override
  List<Object> get props => [smsCode];
}

class PhoneAuthOTPCodeResend extends PhoneAuthEvent {
  final String phoneNumber;
  final int? token;

  PhoneAuthOTPCodeResend({required this.phoneNumber, required this.token});
  @override
  List<Object?> get props => [phoneNumber, token];
}

class PhoneAuthCodeAutoRetrevalTimeout extends PhoneAuthEvent {
  final String verificationId;

  PhoneAuthCodeAutoRetrevalTimeout({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}
