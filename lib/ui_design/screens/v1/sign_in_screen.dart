import 'package:authentication/authentication.dart';
import 'package:authentication/enums.dart';
import 'package:authentication/src/bloc/email_auth_bloc/email_auth_bloc.dart';
import 'package:authentication/ui_design/cubits/cubits.dart';
import 'forget_password_screen.dart';
import 'sign_up_screen.dart';
import 'package:authentication/ui_design/screens/v1/components/buttons.dart';
import 'package:authentication/ui_design/widgets/remember_me.dart';
import 'package:authentication/ui_design/widgets/textfields.dart';
import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class V1SignInScreen extends StatefulWidget {
  static const routeName = 'v1_sign_in_screen';
  const V1SignInScreen({Key? key}) : super(key: key);

  @override
  State<V1SignInScreen> createState() => _V1SignInScreenState();
}

class _V1SignInScreenState extends State<V1SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider<SignInFormCubit>(
      create: (p0) => SignInFormCubit(),
      child: Builder(
          builder: (context) => Scaffold(
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
                    Text("Sign in to your account", style: textTheme.headline6),
                    const SizedBox(height: 24),

                    // Text field for email address
                    SimpleTextFormField(
                        labelText: 'Email',
                        hintText: 'Enter you email address',
                        validator: Validation(RegExpType.emailRegExp).set,
                        onChange: context.read<SignInFormCubit>().setEmail),
                    const SizedBox(height: 18),

                    // Text field for password
                    PasswordTextField(
                        onChange: context.read<SignInFormCubit>().setPassword),

                    // After the password screen, on the right side of the screen,
                    // there is a forget button.
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.of(context)
                            .restorablePushNamedAndRemoveUntil(
                                V1ForgetPasswordScreen.routeName,
                                ModalRoute.withName(
                                    V1ForgetPasswordScreen.routeName)),
                        child: const Text("Forget the password?"),
                      ),
                    ),

                    // There is no logic in just having a checkbox.
                    RememberMe(textTheme: textTheme),
                    const SizedBox(height: 24),

                    BlocBuilder<SignInFormCubit, SignInFormState>(
                        builder: (context, state) => ElevatedButton(
                            onPressed: state.isValid
                                ? () => context.read<EmailAuthBloc>().add(
                                    EmailAuthSignIn(
                                        state.email, state.password))
                                : null,
                            child: const Text('Sign In'))),

                    const SizedBox(height: 24),
                    Text("or continue with", style: textTheme.bodyText2),
                    const SizedBox(height: 24),

                    if (Authentication.showMultiOAuth != null)
                      const OAuthButtons([
                        OAuthProviders.phone,
                        OAuthProviders.google,
                      ]),

                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text('Don’t have an account?',
                          style: textTheme.bodyText2),
                      TextButton(
                        child: const Text('Sign up'),
                        onPressed: () {
                          Navigator.of(context)
                              .restorablePushNamedAndRemoveUntil(
                                  V1SignUpScreen.routeName,
                                  ModalRoute.withName(
                                      V1SignUpScreen.routeName));
                        },
                      )
                    ])
                  ]),
                ),
              ))),
    );
  }
}
