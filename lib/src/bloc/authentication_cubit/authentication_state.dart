part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthorisedState extends AuthenticationState {
  final User user;

  const AuthorisedState(this.user);

  @override
  List<Object> get props => [user];
}

class UnauthorisedState extends AuthenticationState {}
