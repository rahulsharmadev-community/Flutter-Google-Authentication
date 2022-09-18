part of 'cubits.dart';

/// For managing signin credentials, use [SignInFormState].
class SignInFormState {
  final String email, password;

  final bool isEmailValid;
  final bool isPasswordValid;

  /// when both are [email] and [password] are valid
  get isValid => isEmailValid && isPasswordValid;

  const SignInFormState.empty()
      : email = '',
        password = '',
        isEmailValid = false,
        isPasswordValid = false;

  SignInFormState copyWith(
          {String? email,
          String? password,
          bool? isEmailValid,
          bool? isPasswordValid}) =>
      SignInFormState(email ?? this.email, password ?? this.password,
          isEmailValid: isEmailValid ?? this.isEmailValid,
          isPasswordValid: isPasswordValid ?? this.isPasswordValid);

  const SignInFormState(this.email, this.password,
      {this.isEmailValid = false, this.isPasswordValid = false});

  @override
  String toString() {
    // TODO: implement toString
    return '{email: $email, password: $password, isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid}';
  }
}

/// For managing signup credentials, use [SignUpFormState].
class SignUpFormState {
  final String email, password, conformPassword;

  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConformPasswordValid;

  /// known as ```isEmailValid == isPasswordValid == isConformPasswordValid```
  get isValid => isEmailValid && isPasswordValid && isConformPasswordValid;

  get isPasswordSame => password == conformPassword;

  const SignUpFormState.empty()
      : email = '',
        password = '',
        conformPassword = '',
        isEmailValid = false,
        isPasswordValid = false,
        isConformPasswordValid = false;

  SignUpFormState copyWith(
          {String? email,
          String? password,
          String? conformPassword,
          bool? isEmailValid,
          bool? isPasswordValid,
          bool? isConformPasswordValid}) =>
      SignUpFormState(email ?? this.email, password ?? this.password,
          conformPassword ?? this.conformPassword,
          isEmailValid: isEmailValid ?? this.isEmailValid,
          isPasswordValid: isPasswordValid ?? this.isPasswordValid,
          isConformPasswordValid:
              isConformPasswordValid ?? this.isConformPasswordValid);

  const SignUpFormState(this.email, this.password, this.conformPassword,
      {this.isEmailValid = false,
      this.isPasswordValid = false,
      this.isConformPasswordValid = false});

  @override
  String toString() {
    // TODO: implement toString
    return '{$email, $password, $conformPassword, $isEmailValid, $isPasswordValid, $isConformPasswordValid}';
  }
}

/// For managing Phone auth credentials, use [PhoneAuthFormState].
class PhoneAuthFormState {
  final String phoneNumber;

  final bool isValid;

  const PhoneAuthFormState.empty()
      : phoneNumber = '',
        isValid = false;

  const PhoneAuthFormState(this.phoneNumber, {this.isValid = false});
  @override
  String toString() {
    // TODO: implement toString
    return '{phoneNumber: $phoneNumber | isValid: $isValid}';
  }
}

/// For managing forget email, use [ForgetPasswordFormState].
class ForgetPasswordFormState {
  final String email;

  final bool isValid;

  const ForgetPasswordFormState.empty()
      : email = '',
        isValid = false;

  const ForgetPasswordFormState(this.email, {this.isValid = false});

  @override
  String toString() {
    // TODO: implement toString
    return '{email: $email | isValid: $isValid}';
  }
}
