part of 'email_auth_bloc.dart';

abstract class EmailAuthState extends Equatable {
  const EmailAuthState();

  @override
  List<Object> get props => [];
}

class EmailAuthInitialState extends EmailAuthState {}

class EmailAuthCompleteState extends EmailAuthState {}

class EmailAuthLoadingState extends EmailAuthState {}

class EmailAuthErrorState extends EmailAuthState {
  final String msg;

  const EmailAuthErrorState(this.msg);
}
