import 'package:flutter/material.dart';

mixin NavigationStateDelegate<T extends StatefulWidget> on State<T> {
  void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  void replaceWith(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  void goBack(BuildContext context, [Object? result]) {
    Navigator.of(context).pop(result);
  }

  void goBackUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  void goBackAndPush(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).popAndPushNamed(routeName, arguments: arguments);
  }

  void goBackAndPushResult(BuildContext context, Object result) {
    Navigator.of(context).pop(result);
  }
}

mixin NavigationDelegate {
  void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  void replaceWith(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  void goBack(BuildContext context, [Object? result]) {
    Navigator.of(context).pop(result);
  }
}

