import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppScaffold extends StatefulWidget {
  final Widget body;

  const MainAppScaffold({Key? key, required this.body}) : super(key: key);

  @override
  State<MainAppScaffold> createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: widget.body,
    );
  }
}
