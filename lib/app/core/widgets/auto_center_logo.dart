import 'package:flutter/material.dart';

class AutoCenterLogo extends StatelessWidget {
  const AutoCenterLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 200,
        ),
      ],
    );
  }
}
