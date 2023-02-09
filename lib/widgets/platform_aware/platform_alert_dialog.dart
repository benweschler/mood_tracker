import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parchment/widgets/platform_aware/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final bool isDestructiveAction;

  const PlatformAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    this.isDestructiveAction = false,
  }) : super(key: key);

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(
          context, cancelText.toUpperCase(), confirmText.toUpperCase()),
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context, cancelText, confirmText),
    );
  }

  List<Widget> _buildActions(
      BuildContext context, String cancelText, String confirmText) {
    return [
      PlatformAlertDialogAction(
        onPressed: () => _dismiss(context, false),
        child: Text(cancelText),
      ),
      PlatformAlertDialogAction(
        onPressed: () => _dismiss(context, true),
        isDestructiveAction: isDestructiveAction,
        child: Text(confirmText),
      ),
    ];
  }

  void _dismiss(BuildContext context, bool value) {
    Navigator.of(context, rootNavigator: true).pop(value);
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget child;
  final bool isDestructiveAction;
  final VoidCallback onPressed;

  const PlatformAlertDialogAction({
    Key? key,
    required this.child,
    this.isDestructiveAction = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  TextButton buildMaterialWidget(BuildContext context) {
    return TextButton(onPressed: onPressed, child: child);
  }

  @override
  CupertinoDialogAction buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: onPressed,
      isDestructiveAction: isDestructiveAction,
      child: child,
    );
  }
}

Future<bool> showPlatformDialog({
  required BuildContext context,
  required PlatformAlertDialog dialog,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: !Platform.isIOS,
    builder: (_) => dialog,
  );

  // showDialog returns null if the dialog has been dismissed with the back
  // button on Android.
  // here we ensure that we return only true or false
  return Future.value(result ?? false);
}
