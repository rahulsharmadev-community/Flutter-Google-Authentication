import 'package:flutter/material.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Align build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TODO
          Checkbox(value: true, onChanged: (value) {}),
          const Text("Remember me"),
        ],
      ),
    );
  }
}
