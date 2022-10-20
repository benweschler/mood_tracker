import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/theme.dart';

class ModalSheet extends StatelessWidget {
  final Color backgroundColor;
  final Widget? leftAction;
  final Widget? rightAction;
  final Widget child;

  const ModalSheet({
    Key? key,
    required this.backgroundColor,
    this.leftAction,
    this.rightAction,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Corners.medRadius),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leftAction != null || rightAction != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leftAction != null ? leftAction! : const Spacer(),
                  rightAction != null ? rightAction! : const Spacer(),
                ],
              ),
            child,
          ],
        ),
      ),
    );
  }
}
