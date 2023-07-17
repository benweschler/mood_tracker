import 'package:flutter/widgets.dart';
import 'package:parchment/styles.dart';

/// A button that exposes an overlay color that is shown when the button is
/// pressed.
class ResponsiveButton extends StatefulWidget {
  final Widget Function(Color overlayColor) builder;
  final GestureTapCallback? onTap;
  final Color _overlayColor;

  /// A button that adds a light overlay when tapped.
  const ResponsiveButton.light({
    Key? key,
    required this.builder,
    required this.onTap,
  })  : _overlayColor = const Color(0x0FFFFFFF),
        super(key: key);

  /// A button that adds a dark overlay when tapped.
  const ResponsiveButton.dark({
    Key? key,
    required this.builder,
    required this.onTap,
  })  : _overlayColor = const Color(0x0F000000),
        super(key: key);

  @override
  State<ResponsiveButton> createState() => _ResponsiveButtonState();
}

class _ResponsiveButtonState extends State<ResponsiveButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return _BaseResponsiveButton(
      onTap: widget.onTap,
      onPressed: (isPressed) => setState(() => this.isPressed = isPressed),
      child: widget.builder(
        isPressed ? widget._overlayColor : const Color(0x00000000),
      ),
    );
  }
}

/// A responsive button intended to be wrapped around a body made up of strokes,
/// namely an icon or text, rather than a solid body.
class ResponsiveStrokeButton extends StatefulWidget {
  final GestureTapCallback onTap;
  final Widget child;

  const ResponsiveStrokeButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  State<ResponsiveStrokeButton> createState() => _ResponsiveStrokeButtonState();
}

class _ResponsiveStrokeButtonState extends State<ResponsiveStrokeButton>
    with SingleTickerProviderStateMixin {
  // A value of 1 represents the unpressed state with full opacity. This is to
  // ensure that activating the animation corresponds to running the controller
  // forward.
  late final _controller = AnimationController(
    duration: Durations.short,
    value: 1,
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Opacity(
        // Map a controller value of 1 to an opacity of 1 and a controller value
        // of 0 to an opacity of 0.5.
        opacity: _controller.value / 2 + 0.5,
        child: _BaseResponsiveButton(
          onPressed: (isPressed) =>
              isPressed ? _controller.value = 0 : _controller.forward(),
          onTap: widget.onTap,
          child: widget.child,
        ),
      ),
    );
  }
}

class _BaseResponsiveButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final ValueChanged<bool> onPressed;
  final Widget child;

  const _BaseResponsiveButton({
    Key? key,
    required this.onTap,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => onPressed(true),
      onTapCancel: () => onPressed(false),
      onTapUp: (_) => onPressed(false),
      onTap: onTap,
      child: child,
    );
  }
}
