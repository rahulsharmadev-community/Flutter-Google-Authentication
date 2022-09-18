import 'package:authentication/authentication.dart';
import 'package:authentication/enums.dart';
import 'package:authentication/src/bloc/email_auth_bloc/email_auth_bloc.dart';
import 'package:authentication/ui_design/cubits/cubits.dart';
import 'package:authentication/ui_design/widgets/basic.dart';
import 'sign_in_screen.dart';
import 'package:authentication/ui_design/screens/v1/components/buttons.dart';
import 'package:authentication/ui_design/widgets/remember_me.dart';
import 'package:authentication/ui_design/widgets/textfields.dart';
import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class V1SignUpScreen extends StatelessWidget {
  static const routeName = 'v1_sign_up_screen';
  const V1SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider<SignUpFormCubit>(
      create: (p0) => SignUpFormCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
            body: SafeArea(
          minimum: const EdgeInsets.only(top: kToolbarHeight),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // Display an image in the top-center of the screen
              // if image is not null.
              SvgPicture.asset(
                Authentication.logo,
                width: widthOf(context, 30),
              ),
              const SizedBox(height: 24),

              // Text just after the image
              Text("Sign up for account", style: textTheme.headline6),
              const SizedBox(height: 24),

              // Text field for email address
              SimpleTextFormField(
                  labelText: 'Email',
                  hintText: 'Enter you email address',
                  validator: Validation(RegExpType.emailRegExp).set,
                  onChange: context.read<SignUpFormCubit>().setEmail),
              const SizedBox(height: 18),

              // Text field for password
              PasswordTextField(
                  labelText: 'Password',
                  hintText: 'Enter your Password',
                  onChange: context.read<SignUpFormCubit>().setPassword),
              const SizedBox(height: 18),

              // Again a Text field for conform password
              PasswordTextField(
                  labelText: 'Conform Password',
                  hintText: 'Enter same Password again ',
                  onChange: context.read<SignUpFormCubit>().setConformPassword),

              // There is no logic in just having a checkbox.
              RememberMe(textTheme: textTheme),
              const SizedBox(height: 24),

              BlocBuilder<SignUpFormCubit, SignUpFormState>(
                  builder: (context, formState) => ElevatedButton(
                      onPressed: formState.isValid
                          ? () {
                              if (!formState.isPasswordSame) {
                                showSnackbar(
                                    context, 'Both password are not Same');
                              } else {
                                context.read<EmailAuthBloc>().add(
                                    EmailAuthSignUp(
                                        formState.email, formState.password));
                              }
                            }
                          : null,
                      child: const Text('Sign up'))),
              const SizedBox(height: 24),

              Text("or continue with", style: textTheme.bodyText2),
              const SizedBox(height: 24),

              if (Authentication.showMultiOAuth != null)
                const OAuthButtons([
                  OAuthProviders.phone,
                  OAuthProviders.google,
                ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text('Already have an account?', style: textTheme.bodyText2),
                TextButton(
                  child: const Text('Sign In'),
                  onPressed: () => Navigator.of(context)
                      .restorablePushNamedAndRemoveUntil(
                          V1SignInScreen.routeName,
                          ModalRoute.withName(V1SignInScreen.routeName)),
                )
              ])
            ]),
          ),
        ));
      }),
    );
  }
}
