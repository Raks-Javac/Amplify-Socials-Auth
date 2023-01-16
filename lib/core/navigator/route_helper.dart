import 'package:flutter/material.dart';

class WidgetRouteHelper {
  static navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
