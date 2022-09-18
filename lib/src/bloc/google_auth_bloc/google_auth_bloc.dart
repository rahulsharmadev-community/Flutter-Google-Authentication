import 'package:authentication/src/exceptionHandler/google_exception_handler.dart';
import 'package:authentication/src/google_auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  final GoogleAuthRepository _googleAuthRepository;
  GoogleAuthBloc()
      : _googleAuthRepository = GoogleAuthRepository(),
        super(GoogleAuthInitialState()) {
    on<GoogleAuthSignIn>(_onSignIn);
  }

  _onSignIn(event, emit) async {
    try {
      await _googleAuthRepository.signInWithGoogle();
      emit(GoogleAuthCompletedState());
    } on SignInWithGoogleFailure catch (error) {
      emit(GoogleAuthErrorState(error.message));
    }
  }
}
