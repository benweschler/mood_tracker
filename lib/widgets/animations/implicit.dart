import 'package:flutter/widgets.dart';
import 'package:mood_tracker/widgets/animations/transitions.dart';

class AnimatedSingleChildUpdate extends StatefulWidget {
  final Widget child;
  final Key childKey;
  final Duration duration;

  const AnimatedSingleChildUpdate({
    Key? key,
    required this.childKey,
    required this.duration,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedSingleChildUpdate> createState() => _AnimatedSingleChildUpdateState();
}

class _AnimatedSingleChildUpdateState extends State<AnimatedSingleChildUpdate>
    with SingleTickerProviderStateMixin {
  late Widget _firstChild = widget.child;
  late Widget _secondChild = widget.child;

  late final _controller = AnimationController(
    // Initialize a completely animated state, reflecting the fact that no
    // animation is ready until the child is reset.
    value: 1,
    duration: widget.duration,
    vsync: this,
  );
  late final _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedSingleChildUpdate oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    if (widget.childKey != oldWidget.childKey) {
      _firstChild = oldWidget.child;
      _secondChild = widget.child;
      _controller.value = 1 - _controller.value;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CrossFadeTransition(
      animation: _animation,
      firstChild: _firstChild,
      secondChild: _secondChild,
    );
  }
}

class AnimatedFadeTransition extends StatefulWidget {
  final Widget firstChild;
  final Widget secondChild;
  final CrossFadeState crossFadeState;
  final Duration duration;

  const AnimatedFadeTransition({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    required this.crossFadeState,
    required this.duration,
  }) : super(key: key);

  @override
  State<AnimatedFadeTransition> createState() => _AnimatedFadeTransitionState();
}

class _AnimatedFadeTransitionState extends State<AnimatedFadeTransition>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

  @override
  void initState() {
    if (widget.crossFadeState == CrossFadeState.showSecond) {
      _controller.value = 1.0;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedFadeTransition oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    if (widget.crossFadeState != oldWidget.crossFadeState) {
      switch (widget.crossFadeState) {
        case CrossFadeState.showFirst:
          _controller.reverse();
          break;
        case CrossFadeState.showSecond:
          _controller.forward();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CrossFadeTransition(
      animation: _animation,
      firstChild: widget.firstChild,
      secondChild: widget.secondChild,
    );
  }
}