part of 'email_auth_bloc.dart';

abstract class EmailAuthEvent {
  const EmailAuthEvent();

  @override
  List<Object> get props => [];
}

class EmailAuthSignIn extends EmailAuthEvent {
  final String password, email;
  const EmailAuthSignIn(this.email, this.password);
}

class EmailAuthSignUp extends EmailAuthEvent {
  final String password, email;
  const EmailAuthSignUp(this.email, this.password);
}

class EmailAuthChangePassword extends EmailAuthEvent {
  final String email;
  final String newPassword;
  const EmailAuthChangePassword(this.email, this.newPassword);
}

class EmailAuthForgetPassword extends EmailAuthEvent {
  final String email;
  const EmailAuthForgetPassword(this.email);
}
