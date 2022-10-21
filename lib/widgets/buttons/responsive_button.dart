import 'package:flutter/widgets.dart';

/// A button that exposes an overlay color that is shown when the button is
/// pressed.
class ResponsiveButton extends StatefulWidget {
  final Widget Function(Color overlayColor) builder;
  final GestureTapCallback? onTap;
  final Color _overlayColor;

  ResponsiveButton.light({
    Key? key,
    required this.builder,
    required this.onTap,
  })  : _overlayColor = const Color(0xFFFFFFFF).withOpacity(0.1),
        super(key: key);

  ResponsiveButton.dark({
    Key? key,
    required this.builder,
    required this.onTap,
  })  : _overlayColor = const Color(0xFF000000).withOpacity(0.1),
        super(key: key);

  @override
  State<ResponsiveButton> createState() => _ResponsiveButtonState();
}

class _ResponsiveButtonState extends State<ResponsiveButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => setState(() => isPressed = true),
      onTapCancel: () => setState(() => isPressed = false),
      onTapUp: (_) => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: widget.builder(
        widget._overlayColor.withOpacity(isPressed ? 0.06 : 0),
      ),
    );
  }
}
