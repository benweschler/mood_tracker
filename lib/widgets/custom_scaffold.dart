import 'package:flutter/material.dart';
import 'package:parchment/styles.dart';

import 'animations/transitions.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? leading;
  final Widget? center;
  final Widget? trailing;
  final Widget? drawer;
  final Widget? bottomActionButton;
  final bool resizeToAvoidBottomInset;
  final bool addBorderInsets;

  const CustomScaffold({
    Key? key,
    this.scaffoldKey,
    required this.child,
    this.leading,
    this.center,
    this.trailing,
    this.drawer,
    this.bottomActionButton,
    this.resizeToAvoidBottomInset = true,
    this.addBorderInsets = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: drawer,
      body: SafeArea(
        bottom: false,
        minimum: addBorderInsets
            ? const EdgeInsets.symmetric(horizontal: Insets.offset)
            : EdgeInsets.zero,
        child: Column(
          children: [
            if (leading != null || center != null || trailing != null)
              CustomAppBar(
                leading: leading,
                center: center,
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

/// An app bar with the option of a single leading element, a single center
/// element, and a single trailing element.
///
/// Automatically animates itself using a hero animation and cross-fade
/// transition across screens.
class CustomAppBar extends StatelessWidget {
  /// The leading widget shown in the app bar.
  final Widget? leading;

  /// The widget shown at the bottom of the app bar.
  final Widget? center;

  /// The trailing actions shown in the app bar.
  final Widget? trailing;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.center,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      // Only animate between app bars scoped within the same Navigator.
      tag: Navigator.of(context),
      transitionOnUserGestures: true,
      flightShuttleBuilder: _shuttleBuilder,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.med,
          horizontal: Insets.offset,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            if (center != null) Expanded(child: Center(child: center!)),
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
