part of 'google_auth_bloc.dart';

abstract class GoogleAuthEvent extends Equatable {
  const GoogleAuthEvent();

  @override
  List<Object> get props => [];
}

class GoogleAuthInital extends GoogleAuthEvent {}

class GoogleAuthSignIn extends GoogleAuthEvent {}
