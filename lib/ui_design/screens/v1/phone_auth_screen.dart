import 'package:authentication/authentication.dart';
import 'package:authentication/enums.dart';
import 'package:authentication/src/bloc/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:authentication/ui_design/cubits/cubits.dart';
import 'package:authentication/ui_design/widgets/basic.dart';
import 'sign_up_screen.dart';
import 'package:authentication/ui_design/screens/v1/components/buttons.dart';
import 'package:authentication/ui_design/widgets/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class V1PhoneAuthScreen extends StatelessWidget {
  static const String routeName = "/v1_phone_auth_screen";

  const V1PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (p0) => PhoneAuthBloc()),
          BlocProvider(create: (p0) => PhoneAuthFormCubit())
        ],
        child: Builder(builder: (context) {
          return Scaffold(
              body: SafeArea(
                  minimum: const EdgeInsets.only(top: kToolbarHeight),
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
                          listener: (context, state) {
                        if (state is PhoneAuthErrorState) {
                          showSnackbar(context, state.msg);
                        }
                        if (state
                            is PhoneAuthCodeAutoRetrevalTimeoutCompleteState) {
                          showSnackbar(
                              context, 'OTP expired please try agian later.');
                        }
                      }, builder: (context, authState) {
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Display an image in the top-center of the screen
                              // if image is not null.
                              SvgPicture.asset(
                                Authentication.logo,
                                width: widthOf(context, 30),
                              ),
                              const SizedBox(height: 24),

                              // Changes to the authstate will also affect the text.
                              Text(
                                  authState is PhoneAuthSMSCodeReceivedState
                                      ? 'Verify OTP'
                                      : 'Sign in with Phone Number',
                                  style: textTheme.headline6),
                              const SizedBox(height: 8),

                              // Changes to the authstate will also affect the text.
                              Text(
                                  authState is PhoneAuthSMSCodeReceivedState
                                      ? 'Enter your OTP, to reset your password.'
                                      : "Enter your phone number, and we'll send you an OTP for verification.",
                                  textAlign: TextAlign.center,
                                  style: textTheme.subtitle2),
                              const SizedBox(height: kToolbarHeight),

                              // Change the text fiel when authstate is change
                              authState is PhoneAuthSMSCodeReceivedState
                                  ? Pinput(
                                      length: 6,
                                      hapticFeedbackType:
                                          HapticFeedbackType.mediumImpact,
                                      onCompleted: (value) => context
                                          .read<PhoneAuthBloc>()
                                          .add(PhoneAuthVerifyOTPCode(
                                              smsCode: value,
                                              verificationId:
                                                  authState.verificationId)))
                                  : PhoneNumberField(
                                      keyboardType: TextInputType.phone,
                                      onChange: context
                                          .read<PhoneAuthFormCubit>()
                                          .set),
                              const SizedBox(height: 24),

                              displayButton(authState),

                              const SizedBox(height: 24),
                              Text("or continue with",
                                  style: textTheme.bodyText2),
                              const SizedBox(height: 24),
                              if (Authentication.showMultiOAuth != null)
                                const OAuthButtons([
                                  OAuthProviders.email,
                                  OAuthProviders.google,
                                ]),

                              const SizedBox(height: 24),
                              Row(mainAxisSize: MainAxisSize.min, children: [
                                Text('Don’t have an account? ',
                                    style: textTheme.subtitle2),
                                TextButton(
                                    child: Text('Sign up',
                                        style: textTheme.subtitle2!.copyWith(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            V1SignUpScreen.routeName,
                                            ModalRoute.withName(
                                                V1SignUpScreen.routeName)))
                              ])
                            ]);
                      }))));
        }));
  }

  Widget displayButton(PhoneAuthState authState) {
    // Only TWO states need to be handled in order for the button
    // to display correctly according to [PhoneAuthState].
    if (authState is PhoneAuthLoadingState) {
      return const CircularProgressIndicator();
    } else {
      return BlocBuilder<PhoneAuthFormCubit, PhoneAuthFormState>(
          builder: (context, phoneState) {
        // Display a Verify button when [PhoneAuthSMSCodeReceivedState] occered
        // else display a send otp button.
        return (authState is PhoneAuthSMSCodeReceivedState)
            ? ElevatedButton(
                onPressed: phoneState.isValid
                    ? () => context.read<PhoneAuthBloc>().add(
                        PhoneAuthVerifyOTPCode(
                            smsCode: phoneState.phoneNumber,
                            verificationId: authState.verificationId))
                    : null,
                child: const Text('Verify'))
            : ElevatedButton(
                onPressed: phoneState.isValid
                    ? () => context.read<PhoneAuthBloc>().add(
                        PhoneAuthVerifyNumber(
                            phoneNumber: phoneState.phoneNumber))
                    : null,
                child: const Text('Send OTP'));
      });
    }
  }
}

// class BuildTimer extends StatelessWidget {
//   const BuildTimer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Resend OTP in "),
//         TweenAnimationBuilder(
//           tween: Tween(begin: 30.0, end: 0.0),
//           duration: const Duration(seconds: 30),
//           builder: (_, dynamic value, child) => Text(
//             "${value.toInt()}s",
//             style: TextStyle(color: Theme.of(context).primaryColor),
//           ),
//         ),
//       ],
//     );
//   }
// }
