import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AppRoute<T> = CupertinoPageRoute<T>;

extension NavigatorUtils on BuildContext {
  Future<T?> showModal<T>(Widget sheet) => showModalBottomSheet<T>(
    context: this,
    // Removes shadow
    elevation: 0,
    backgroundColor: Colors.transparent,
    builder: (_) => sheet,
  );
}

Route<T> convertToRoute<T>(Widget page) => AppRoute<T>(builder: (_) => page);
