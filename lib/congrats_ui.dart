import 'package:flutter/material.dart';

import 'core/configurations/aws_config.dart';

class CongratsUI extends StatelessWidget {
  final String signInMode;
  final AuthType authType;
  const CongratsUI(
      {super.key, required this.authType, required this.signInMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("Congratulations you've just logged in with $signInMode"),
        ],
      )),
    );
  }
}
