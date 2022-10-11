import 'package:flutter/material.dart';
import 'package:mood_tracker/theme.dart';

import 'animations/transitions.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Widget? bottomActionButton;
  final bool resizeToAvoidBottomInset;

  const CustomScaffold({
    Key? key,
    required this.child,
    this.leading,
    this.trailing,
    this.bottomActionButton,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: Insets.offset),
        child: Column(
          children: [
            if (leading != null || trailing != null)
              CustomAppBar(
                leading: leading,
                trailing: trailing,
              ),
            Expanded(
              child: Stack(
                children: [
                  child,
                  if (bottomActionButton != null)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: Insets.offset,
                      child: bottomActionButton!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;

  const CustomAppBar({Key? key, this.leading, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      // Only animate between app bars scoped within the same Navigator.
      tag: Navigator.of(context),
      transitionOnUserGestures: true,
      flightShuttleBuilder: _shuttleBuilder,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Insets.med),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }

  Widget _shuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return CrossFadeTransition(
      animation: flightDirection == HeroFlightDirection.push
          ? animation
          : ReverseAnimation(animation),
      firstChild: fromHeroContext.widget,
      secondChild: toHeroContext.widget,
    );
  }
}
