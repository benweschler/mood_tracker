import 'package:flutter/widgets.dart';

class CrossFadeTransition extends AnimatedWidget {
  final Animation<double> animation;
  final Widget firstChild;
  final Widget secondChild;

  const CrossFadeTransition({
    super.key,
    required this.animation,
    required this.firstChild,
    required this.secondChild,
  }) : super(listenable: animation);

  static final _quadraticValleyTween = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(begin: 1, end: 0)
          .chain(CurveTween(curve: Curves.easeOut)),
      weight: 0.5,
    ),
    TweenSequenceItem(
      tween: Tween<double>(begin: 0, end: 1)
          .chain(CurveTween(curve: Curves.easeIn)),
      weight: 0.5,
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _quadraticValleyTween.animate(animation),
      child: animation.value <= 0.5 ? firstChild : secondChild,
    );
  }
}

/// Identical to [CrossFadeTransition], but take an explicit position rather
/// than an animation of the position.
class CrossFadeOpacity extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  final double position;

  const CrossFadeOpacity({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    required this.position,
  }) : super(key: key);

  double positionToOpacity(double position) {
    if (position <= 0.5) return 1 - position * 2;
    return 2 * position - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: positionToOpacity(position),
      child: position <= 0.5 ? firstChild : secondChild,
    );
  }
}
