import 'package:flutter_bloc/flutter_bloc.dart';
part 'state.dart';

class SignInFormCubit extends Cubit<SignInFormState> {
  SignInFormCubit() : super(const SignInFormState.empty());

  void setEmail(String email, bool isValid) =>
      emit(state.copyWith(email: email, isEmailValid: isValid));

  void setPassword(String password, bool isValid) =>
      emit(state.copyWith(password: password, isPasswordValid: isValid));
}

class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit() : super(const SignUpFormState.empty());
  void setEmail(String email, bool isValid) =>
      emit(state.copyWith(email: email, isEmailValid: isValid));

  void setPassword(String password, bool isValid) =>
      emit(state.copyWith(password: password, isPasswordValid: isValid));

  void setConformPassword(String conformPassword, bool isValid) =>
      emit(state.copyWith(
          conformPassword: conformPassword, isConformPasswordValid: isValid));
}

class PhoneAuthFormCubit extends Cubit<PhoneAuthFormState> {
  PhoneAuthFormCubit() : super(const PhoneAuthFormState.empty());
  void set(String no, bool isValid) =>
      emit(PhoneAuthFormState(no, isValid: isValid));
}

class ForgetPasswordFormCubit extends Cubit<ForgetPasswordFormState> {
  ForgetPasswordFormCubit() : super(const ForgetPasswordFormState.empty());
  void set(String email, bool isValid) =>
      emit(ForgetPasswordFormState(email, isValid: isValid));
}
