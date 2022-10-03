import 'package:flutter/material.dart';
import 'package:mood_tracker/theme.dart';

class ActionButton extends StatefulWidget {
  final GestureTapCallback onTap;
  final Color color;
  final Widget child;

  const ActionButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapCancel: () => setState(() => isPressed = false),
      onTapUp: (_) => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(Insets.lg),
        decoration: BoxDecoration(
          color: Color.alphaBlend(
            Colors.black.withOpacity(isPressed ? 0.1 : 0),
            widget.color,
          ),
          borderRadius: Corners.medBorderRadius,
        ),
        child: widget.child,
      ),
    );
  }
}
