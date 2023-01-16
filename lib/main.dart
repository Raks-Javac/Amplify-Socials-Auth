import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'congrats_ui.dart';
import 'core/configurations/aws_config.dart';
import 'core/navigator/route_helper.dart';

const String appName = "Amplify flutter auth";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  AwsInAppConfig.instance.addInAppPlugin();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                final result = await AwsInAppConfig.instance
                    .signInWithAws(AuthType.facebook);
                if (result != null) {
                  // ignore: use_build_context_synchronously
                  WidgetRouteHelper.navigateToRemoveAll(
                      context,
                      const CongratsUI(
                          authType: AuthType.facebook, signInMode: "facebook"));
                } else {
                  // ignore: use_build_context_synchronously
                  WidgetRouteHelper.showButtomSheetInApp(
                      context, "Cannot sign in with facebook");
                }
              },
              child: const Text("Sign In with facebook"),
            ),
            TextButton(
              onPressed: () async {
                final result = await AwsInAppConfig.instance
                    .signInWithAws(AuthType.goggle);
                if (result != null) {
                  // ignore: use_build_context_synchronously
                  WidgetRouteHelper.navigateToRemoveAll(
                      context,
                      const CongratsUI(
                          authType: AuthType.goggle, signInMode: "Google"));
                } else {
                  // ignore: use_build_context_synchronously
                  WidgetRouteHelper.showButtomSheetInApp(
                      context, "Cannot sign in with Google");
                }
              },
              child: const Text("Sign In with Google"),
            ),
            TextButton(
              onPressed: () async {
                final result = await AwsInAppConfig.instance
                    .signInWithAws(AuthType.amazon);
                if (result != null) {
                  // ignore: use_build_context_synchronously
                  WidgetRouteHelper.navigateToRemoveAll(
                      context,
                      const CongratsUI(
                          authType: AuthType.amazon, signInMode: "Amazon"));
                } else {
                  // ignore: use_build_context_synchronously
                  WidgetRouteHelper.showButtomSheetInApp(
                      context, "Cannot sign in with amazon");
                }
              },
              child: const Text("Sign In with Amazon"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
