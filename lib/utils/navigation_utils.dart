import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AppRoute<T> = CupertinoPageRoute<T>;

extension NavigatorUtils on BuildContext {
  Future<T?> push<T extends Object?>(
    Widget page, {
    bool fullscreenDialog = false,
    bool rootNavigator = false,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).push<T>(AppRoute<T>(
        builder: (_) => page,
        fullscreenDialog: fullscreenDialog,
      ));

  void pop<T extends Object?>({T? result, bool rootNavigator = false}) =>
      Navigator.of(this, rootNavigator: rootNavigator).pop(result);

  Future<T?> showModal<T>(Widget sheet) => showModalBottomSheet<T>(
        context: this,
        backgroundColor: Colors.transparent,
        builder: (_) => sheet,
      );
}

Route<T> convertToRoute<T>(Widget page) => AppRoute<T>(builder: (_) => page);
