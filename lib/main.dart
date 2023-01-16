import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/configurations/aws_config.dart';

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Scaffold(
                                body: Center(
                                    child: Text("Sign in with facebook")),
                              )));
                } else {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          const Text("Cannot sign in with facebook"));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Scaffold(
                                body:
                                    Center(child: Text("Sign in with Amazon")),
                              )));
                } else {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          const Text("Cannot sign in with Amazon"));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Scaffold(
                                body:
                                    Center(child: Text("Sign in with Amazon")),
                              )));
                } else {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          const Text("Cannot sign in with Amazon"));
                }
              },
              child: const Text("Sign In with Amazon"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Sign In with Apple"),
            ),
            // TextButton(
            //   onPressed: () {
            //     AwsInAppConfig.instance.signOutWithAws();
            //   },
            //   child: const Text("Sign out"),
            // ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
