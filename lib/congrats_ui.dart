import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'core/configurations/aws_config.dart';

class CongratsUI extends StatefulWidget {
  final String signInMode;
  final AuthType authType;
  const CongratsUI(
      {super.key, required this.authType, required this.signInMode});

  @override
  State<CongratsUI> createState() => _CongratsUIState();
}

class _CongratsUIState extends State<CongratsUI> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      blastDirectionality: BlastDirectionality.explosive,
      confettiController: _confettiController,
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            Text(
                "Congratulations you've just logged in with ${widget.signInMode}"),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                AwsInAppConfig.instance.signOutWithAws();
              },
              child: const Text("Sign out"),
            ),
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}
