import 'package:config/config.dart';
import 'package:flutter/material.dart';

class SimpleTextFormField extends StatefulWidget {
  final Function(String text, bool isValid) onChange;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const SimpleTextFormField(
      {Key? key,
      required this.onChange,
      this.validator,
      this.keyboardType,
      required this.labelText,
      required this.hintText})
      : super(key: key);

  @override
  State<SimpleTextFormField> createState() => _SimpleTextFormFieldState();
}

class _SimpleTextFormFieldState extends State<SimpleTextFormField> {
  late final TextEditingController controller;
  late bool isObscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscureText = true;
    controller = TextEditingController()
      ..addListener(
        () => setState(() {}),
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  GlobalKey<FormFieldState> _globalKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _globalKey,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: (e) => widget.onChange(
          controller.text,
          controller.text.isNotEmpty
              ? (_globalKey.currentState?.validate() ?? false)
              : false),
      maxLines: 1,
      style: Theme.of(context).textTheme.subtitle2,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: const OutlineInputBorder(),
          suffixIcon: controller.text.isNotEmpty
              ? InkResponse(
                  child: const Icon(Icons.clear),
                  onTap: () => setState(() {
                        controller.clear();
                        widget.onChange('', false);
                      }))
              : null),
    );
  }
}

/// Textfield specifically created to capture secure login
/// information like a password or card number
///
/// ```
/// validator = Validation(RegExpType.passwordRegExp,
///               errorMsg: 'password not in the proper format').set
/// ```
class PasswordTextField extends StatefulWidget {
  final Function(String text, bool isValid) onChange;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  const PasswordTextField(
      {Key? key,
      required this.onChange,
      this.labelText = 'Password',
      this.validator,
      this.hintText = "Enter your password"})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late bool isObscureText;
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController()
      ..addListener(
        () => setState(() {}),
      );
    isObscureText = true;
  }

  GlobalKey<FormFieldState> _globalKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _globalKey,
      controller: controller,
      obscureText: isObscureText,
      enableInteractiveSelection: false,
      obscuringCharacter: '*',
      onChanged: (e) => widget.onChange(
          controller.text,
          controller.text.isNotEmpty
              ? (_globalKey.currentState?.validate() ?? false)
              : false),
      style: Theme.of(context).textTheme.subtitle2,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator ??
          Validation(RegExpType.passwordRegExp,
                  errorMsg: 'password not in the proper format')
              .set,
      decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder(gapPadding: 2),
          suffixIcon: controller.text.isNotEmpty
              ? InkResponse(
                  child: Icon(
                    Icons.remove_red_eye_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTapDown: (_) => setState(() => isObscureText = false),
                  onTapUp: (_) => setState(() => isObscureText = true))
              : null),
    );
  }
}

TextFormField buildOTPFormField(
    {Function(String)? onChanged, TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    obscureText: true,
    onChanged: onChanged,
    keyboardType: TextInputType.number,
    validator: Validation(RegExpType.numberRegExp).set,
    minLines: 1,
    maxLength: 6,
    textAlign: TextAlign.center,
    style: const TextStyle(wordSpacing: 2),
    decoration: const InputDecoration(
      labelText: "OTP Verify",
      // hintText: "Enter your OTP",
      hintText: "ー  ー  ー  ー  ー  ー",
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}
