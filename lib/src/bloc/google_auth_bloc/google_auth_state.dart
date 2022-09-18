part of 'google_auth_bloc.dart';

abstract class GoogleAuthState extends Equatable {
  const GoogleAuthState();

  @override
  List<Object> get props => [];
}

class GoogleAuthLoadingState extends GoogleAuthState {}

class GoogleAuthInitialState extends GoogleAuthState {}

class GoogleAuthErrorState extends GoogleAuthState {
  final String msg;
  const GoogleAuthErrorState(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class GoogleAuthCompletedState extends GoogleAuthState {
  // final User user;
  // const GoogleAuthAuthorizedState(this.user);
}
