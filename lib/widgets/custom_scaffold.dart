import 'package:flutter/material.dart';
import 'package:parchment/theme.dart';

import 'animations/transitions.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Widget? bottomActionButton;
  final bool resizeToAvoidBottomInset;
  final bool addBorderInsets;

  const CustomScaffold({
    Key? key,
    required this.child,
    this.leading,
    this.trailing,
    this.bottomActionButton,
    this.resizeToAvoidBottomInset = true,
    this.addBorderInsets = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        bottom: false,
        minimum: addBorderInsets
            ? const EdgeInsets.symmetric(horizontal: Insets.offset)
            : EdgeInsets.zero,
        child: Column(
          children: [
            if (leading != null || trailing != null)
              CustomAppBar(
                leading: leading,
                trailing: trailing,
              ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  if (bottomActionButton != null)
                    Positioned(
                      // The bottom action button should always be padded, so if
                      // the entire body of the scaffold isn't padded, add
                      // padding to the action button here.
                      left:
                          Insets.offset + (addBorderInsets ? 0 : Insets.offset),
                      right:
                          Insets.offset + (addBorderInsets ? 0 : Insets.offset),
                      bottom: Insets.offset,
                      child: SafeArea(child: bottomActionButton!),
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
