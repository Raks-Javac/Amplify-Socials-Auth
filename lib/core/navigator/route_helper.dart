import 'package:flutter/material.dart';

class WidgetRouteHelper {
  static navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static navigateToRemoveAll(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (predict) => false);
  }

  static showButtomSheetInApp(BuildContext context, String message) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(message),
                ],
              ),
            ));
  }
}
