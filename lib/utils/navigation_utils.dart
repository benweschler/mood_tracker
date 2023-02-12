import 'package:flutter/material.dart';

extension NavigatorUtils on BuildContext {
  Future<T?> showModal<T>(Widget sheet) => showModalBottomSheet<T>(
        context: this,
        backgroundColor: Colors.transparent,
        builder: (_) => sheet,
      );
}
