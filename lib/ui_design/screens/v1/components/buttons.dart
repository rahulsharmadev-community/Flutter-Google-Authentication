import 'package:authentication/authentication.dart';

import '/enums.dart';
import 'package:authentication/src/bloc/google_auth_bloc/google_auth_bloc.dart';
import 'package:authentication/ui_design/screens/v1/v1.dart';
import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OAuthButtons extends StatelessWidget {
  final List<OAuthProviders> providers;
  const OAuthButtons(this.providers, {super.key});
  @override
  Widget build(BuildContext context) {
    MapEntry<String, VoidCallback> svgPath(OAuthProviders authorisedType) {
      switch (authorisedType) {
        case OAuthProviders.google:
          return MapEntry('packages/authentication/assets/google_svg.svg',
              () async {
            context.read<GoogleAuthBloc>().add(GoogleAuthSignIn());
          });
        case OAuthProviders.phone:
          return MapEntry(
              'packages/authentication/assets/phone_svg.svg',
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                  V1PhoneAuthScreen.routeName,
                  ModalRoute.withName(V1PhoneAuthScreen.routeName)));
        case OAuthProviders.facebook:
          return MapEntry(
              'packages/authentication/assets/facebook_svg.svg', () {});
        case OAuthProviders.twitter:
          return MapEntry(
              'packages/authentication/assets/twitter_svg.svg', () {});
        case OAuthProviders.email:
          return MapEntry(
              'packages/authentication/assets/email_svg.svg',
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                  V1SignInScreen.routeName,
                  ModalRoute.withName(V1SignInScreen.routeName)));
        case OAuthProviders.microsoft:
          return MapEntry(
              'packages/authentication/assets/microsoft_svg.svg', () {});
        case OAuthProviders.github:
          return MapEntry(
              'packages/authentication/assets/github_svg.svg', () {});
        default:
          return MapEntry(
              'packages/authentication/assets/anonymous_svg.svg', () {});
      }
    }

    Widget button(String name,
        {required VoidCallback? onPressed, required String svgPath}) {
      return OutlinedButton(
        onPressed: onPressed,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(svgPath),
          const SizedBox(width: 16),
          Text(name[0].toUpperCase() + name.substring(1),
              style: Theme.of(context).textTheme.subtitle2)
        ]),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 48,
          width: widthOf(context, 100),
          child: ListView.separated(
              physics: Authentication.showMultiOAuth?.horizontalScrollPhysics,
              scrollDirection: Axis.horizontal,
              itemCount: providers.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final temp = svgPath(providers[index]);
                return SizedBox(
                  width: widthOf(context, 50) - 24,
                  child: button(providers[index].name,
                      svgPath: temp.key, onPressed: temp.value),
                );
              }),
        ),
        if (Authentication.showMultiOAuth?.showExtendedButton ?? true)
          InkWell(
            onTap: () {
              printLog('Show more');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("show more",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Theme.of(context).primaryColor)),
            ),
          ),
      ],
    );
  }
}
