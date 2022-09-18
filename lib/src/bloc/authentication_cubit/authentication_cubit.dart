import 'dart:async';
import 'package:authentication/src/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:config/config.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  late final StreamSubscription subscription;
  AuthenticationCubit() : super(UnauthorisedState()) {
    subscription =
        firebase_auth.FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        printLog(user);
        emit(AuthorisedState(user.toUser));
      } else {
        emit(UnauthorisedState());
      }
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    subscription.cancel();
    return super.close();
  }

  Future<void> signOut() async => firebase_auth.FirebaseAuth.instance.signOut();
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
