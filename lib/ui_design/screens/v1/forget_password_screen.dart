import '/authentication.dart';
import '/enums.dart';
import '/src/bloc/email_auth_bloc/email_auth_bloc.dart';
import '/ui_design/cubits/cubits.dart'
    show ForgetPasswordFormCubit, ForgetPasswordFormState;
import 'sign_up_screen.dart';
import '/ui_design/screens/v1/components/buttons.dart';
import '/ui_design/widgets/textfields.dart' show SimpleTextFormField;
import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class V1ForgetPasswordScreen extends StatelessWidget {
  static const routeName = 'v1_forget_password_screen';
  const V1ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (p0) => ForgetPasswordFormCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
            body: SafeArea(
          minimum: const EdgeInsets.only(top: kToolbarHeight),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SvgPicture.asset(Authentication.logo,
                  width: widthOf(context, 30)),
              const SizedBox(height: 24),
              Text("Forget password", style: textTheme.headline6),
              const SizedBox(height: 8),
              Text(
                  "Enter your email, and we'll send you an OTP to reset your password.",
                  textAlign: TextAlign.center,
                  style: textTheme.subtitle2),
              const SizedBox(height: kToolbarHeight),
              SimpleTextFormField(
                  labelText: 'Email',
                  hintText: 'Enter you email address',
                  onChange: context.read<ForgetPasswordFormCubit>().set),
              const SizedBox(height: 24),
              BlocBuilder<ForgetPasswordFormCubit, ForgetPasswordFormState>(
                  builder: (context, formState) {
                return ElevatedButton(
                    onPressed: formState.isValid
                        ? () => context
                            .read<EmailAuthBloc>()
                            .add(EmailAuthForgetPassword(formState.email))
                        : null,
                    child: const Text('Send Instruction'));
              }),
              const SizedBox(height: 24),
              Text("or continue with", style: textTheme.bodyText2),
              const SizedBox(height: 24),
              if (Authentication.showMultiOAuth != null)
                const OAuthButtons([
                  OAuthProviders.phone,
                  OAuthProviders.google,
                ]),
              const SizedBox(height: 24),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text('Don’t have an account? ', style: textTheme.subtitle2),
                TextButton(
                    child: Text('Sign up',
                        style: textTheme.subtitle2!
                            .copyWith(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          V1SignUpScreen.routeName,
                          ModalRoute.withName(V1SignUpScreen.routeName));
                    })
              ])
            ]),
          ),
        ));
      }),
    );
  }
}
