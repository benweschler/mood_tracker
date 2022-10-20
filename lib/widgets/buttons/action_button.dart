import 'package:flutter/material.dart';
import 'package:mood_tracker/theme.dart';

class ActionButton extends StatefulWidget {
  final String label;
  final Color color;
  final GestureTapCallback onTap;

  final IconData? icon;

  const ActionButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.label,
    this.icon,
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
        padding: const EdgeInsets.all(Insets.med),
        decoration: BoxDecoration(
          color: Color.alphaBlend(
            Colors.black.withOpacity(isPressed ? 0.1 : 0),
            widget.color,
          ),
          borderRadius: Corners.medBorderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: TextStyles.title.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            if (widget.icon != null) ...[
              const SizedBox(width: Insets.sm),
              Icon(
                widget.icon,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
