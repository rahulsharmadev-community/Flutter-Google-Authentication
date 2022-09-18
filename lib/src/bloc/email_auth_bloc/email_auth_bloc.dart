import 'dart:async';
import 'package:authentication/src/email_password_repo.dart';
import 'package:authentication/src/exceptionHandler/google_exception_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'email_auth_event.dart';
part 'email_auth_state.dart';

class EmailAuthBloc extends Bloc<EmailAuthEvent, EmailAuthState> {
  late final EmailPasswordAuthRepository emailAuthRepository;
  EmailAuthBloc()
      : emailAuthRepository = EmailPasswordAuthRepository(),
        super(EmailAuthInitialState()) {
    on<EmailAuthSignIn>(_onSignIn);
    on<EmailAuthSignUp>(_onSignUp);
    on<EmailAuthChangePassword>(_onChangePassword);
    on<EmailAuthForgetPassword>(_onForgetPassword);
  }

  FutureOr<void> _onSignIn(
      EmailAuthSignIn event, Emitter<EmailAuthState> emit) async {
    try {
      emit(EmailAuthLoadingState());
      await emailAuthRepository.signIn(
          email: event.email, password: event.password);
      emit(EmailAuthCompleteState());
    } on SignInWithEmailAndPasswordFailure catch (error) {
      emit(EmailAuthErrorState(error.message));
    }
  }

  FutureOr<void> _onSignUp(
      EmailAuthSignUp event, Emitter<EmailAuthState> emit) async {
    try {
      emit(EmailAuthLoadingState());
      await emailAuthRepository.createUser(
          email: event.email, password: event.password);
      await emailAuthRepository.sendEmailVerificationLink();
      emit(EmailAuthCompleteState());
    } on SignUpWithEmailAndPasswordFailure catch (error) {
      emit(EmailAuthErrorState(error.message));
    } on SendEmailVerificationFailure catch (error) {
      emit(EmailAuthErrorState(error.message));
    }
  }

  FutureOr<void> _onChangePassword(
      EmailAuthChangePassword event, Emitter<EmailAuthState> emit) async {
    try {
      emit(EmailAuthLoadingState());
      await emailAuthRepository.changePassword(password: event.newPassword);
      emit(EmailAuthCompleteState());
    } on ChangePasswordFailure catch (error) {
      emit(EmailAuthErrorState(error.message));
    }
  }

  FutureOr<void> _onForgetPassword(
      EmailAuthForgetPassword event, Emitter<EmailAuthState> emit) async {
    try {
      emit(EmailAuthLoadingState());
      await emailAuthRepository.forgetPassword(email: event.email);
      emit(EmailAuthCompleteState());
    } on ForgetPasswordFailure catch (error) {
      emit(EmailAuthErrorState(error.message));
    }
  }
}
