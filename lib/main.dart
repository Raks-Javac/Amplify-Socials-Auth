import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'congrats_ui.dart';
import 'core/configurations/aws_config.dart';
import 'core/navigator/route_helper.dart';

const String facebookLogoPath = "images/facebook_logo.png";
const String googleLogoPath = "images/google_logo.png";
const String amazonLogoPath = "images/amazon_logo.png";
const String appName = "Amplify flutter auth";
TextStyle generalStyle = const TextStyle();
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
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text(appName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonReuse(facebookLogoPath, () async {
                AwsInAppConfig.instance
                    .signInWithAws(AuthType.facebook)!
                    .then((result) {
                  if (result != null) {
                    // ignore: use_build_context_synchronously
                    WidgetRouteHelper.navigateToRemoveAll(
                        context,
                        const CongratsUI(
                            authType: AuthType.facebook,
                            signInMode: "facebook"));
                  } else {
                    // ignore: use_build_context_synchronously
                    WidgetRouteHelper.showButtomSheetInApp(
                        context, "Cannot sign in with facebook");
                  }
                });
              }),
              ButtonReuse(googleLogoPath, () async {
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
              }),
              ButtonReuse(amazonLogoPath, () async {
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
              })
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ButtonReuse extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  const ButtonReuse(this.iconPath, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () async {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign In with",
              style: generalStyle.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              iconPath,
              width: 30,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
