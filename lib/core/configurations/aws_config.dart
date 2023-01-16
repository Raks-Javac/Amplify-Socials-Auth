// Amplify Flutter Packages
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ampplify_socials_auth/amplifyconfiguration.dart';

enum AuthType {
  facebook,
  amazon,
  apple,
  goggle,
}

class AwsInAppConfig {
  AwsInAppConfig._();
  static AwsInAppConfig instance = AwsInAppConfig._();

  Future<void> addInAppPlugin() async {
    // Add any Amplify plugins you want to use
    final analyticsPlugin = AmplifyAnalyticsPinpoint();
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugin(authPlugin);
    await Amplify.addPlugin(analyticsPlugin);

    // You can use addPlugins if you are going to be adding multiple plugins
    // await Amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  AuthProvider returnAuthType(AuthType authType) {
    switch (authType) {
      case AuthType.amazon:
        return AuthProvider.amazon;
      case AuthType.facebook:
        return AuthProvider.facebook;
      case AuthType.goggle:
        return AuthProvider.google;
      case AuthType.apple:
        return AuthProvider.apple;

      default:
        return AuthProvider.amazon;
    }
  }

  //sign in with facebook
  Future<SignInResult?>? signInWithAws(AuthType authType) async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
          provider: returnAuthType(authType));
      return result;
    } on AmplifyException catch (e) {
      print("Amplify exception ${e.underlyingException}");
      return null;
    }
  }

  //sign in with facebook
  Future<void> signOutWithAws() async {
    try {
      final SignOutResult result = await Amplify.Auth.signOut(
          options: const SignOutOptions(globalSignOut: false));
      print('Result: ${result.toString()}');
    } on AmplifyException catch (e) {
      print("Amplify exception ${e.underlyingException}");
    }
  }
}
