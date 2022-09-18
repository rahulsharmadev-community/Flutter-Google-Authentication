library authentication;

import 'package:authentication/enums.dart';
import 'package:authentication/src/bloc/authentication_cubit/authentication_cubit.dart';
import 'package:authentication/src/bloc/email_auth_bloc/email_auth_bloc.dart';
import 'package:authentication/ui_design/widgets/basic.dart';
import 'package:config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/bloc/google_auth_bloc/google_auth_bloc.dart';
import 'ui_design/screens/v1/v1.dart';

class MultiOAuthCredential {
  final ScrollPhysics? horizontalScrollPhysics;
  final bool showExtendedButton;
  MultiOAuthCredential(
      {this.horizontalScrollPhysics, this.showExtendedButton = false});
}

class Authentication extends StatelessWidget {
  static late String _logo;
  static String get logo => _logo;
  final ThemeData themeData;
  final Color? bgColor;
  static late MultiOAuthCredential? _showMultiOAuth;
  static MultiOAuthCredential? get showMultiOAuth => _showMultiOAuth;
  final MaterialApp child;
  Authentication({
    super.key,
    required String centerImage,
    required this.themeData,
    required this.child,
    this.bgColor,
    MultiOAuthCredential? showMultiOAuth,
  }) {
    _logo = centerImage;
    _showMultiOAuth = showMultiOAuth;
  }

  static  user(BuildContext context) =>
      (context.watch<AuthenticationCubit>().state as AuthorisedState).user;
  static signOut(BuildContext context) =>
      context.read<AuthenticationCubit>().signOut();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthenticationCubit()),
        BlocProvider(create: (_) => GoogleAuthBloc()),
        BlocProvider(create: (_) => EmailAuthBloc()),
      ],
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
        return state is AuthorisedState
            ? child
            : MaterialApp(
                theme: themeData.copyWith(
                    scaffoldBackgroundColor: bgColor,
                    backgroundColor: bgColor,
                    pageTransitionsTheme: PageTransitionsTheme(builders: {
                      TargetPlatform.android: _CustomPageTransitions()
                    })),
                debugShowCheckedModeBanner: Config.isDebugMode = true,
                initialRoute: V1SignInScreen.routeName,
                routes: {
                  V1SignInScreen.routeName: (_) => const V1SignInScreen(),
                  V1SignUpScreen.routeName: (_) => const V1SignUpScreen(),
                  V1ForgetPasswordScreen.routeName: (_) =>
                      const V1ForgetPasswordScreen(),
                  V1PhoneAuthScreen.routeName: (_) => const V1PhoneAuthScreen()
                },
              );
      }),
    );
  }
}

/// User for Custom Page Transitions, as well as for listening
///  to and responding to bloc state information
class _CustomPageTransitions extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // TODO: implement buildTransitions

    void snackbar(context, text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xffFFB9B9),
          content: Text(
            text,
            style: const TextStyle(color: Color(0xffD51515)),
          )));
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<GoogleAuthBloc, GoogleAuthState>(
          listener: (ctx, state) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            if (state is GoogleAuthErrorState) {
              snackbar(ctx, state.msg);
            }
            if (state is GoogleAuthLoadingState) {
              loadingSnakBar(context);
            }
          },
        ),
        BlocListener<EmailAuthBloc, EmailAuthState>(
          listener: (ctx, state) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            if (state is EmailAuthErrorState) {
              snackbar(ctx, state.msg);
            }
            if (state is EmailAuthLoadingState) {
              loadingSnakBar(context);
            }
          },
        )
      ],
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> loadingSnakBar(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 8,
      margin: EdgeInsets.symmetric(
          horizontal: widthOf(context, 50) - 32,
          vertical: heightOf(context, 50) - 32),
      behavior: SnackBarBehavior.floating,
      content: Center(child: CircularProgressIndicator()),
    ));
  }
}
