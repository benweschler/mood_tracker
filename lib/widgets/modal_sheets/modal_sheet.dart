import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parchment/theme.dart';

class ModalSheet extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;

  const ModalSheet({
    Key? key,
    required this.backgroundColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(Insets.sm),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.contrastColor, width: 1),
          color: backgroundColor,
          borderRadius: Corners.medBorderRadius,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              child,
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(Insets.sm),
                    child: _ModalSheetHandle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModalSheetHandle extends StatelessWidget {
  final _handelHeight = Insets.xs;

  const _ModalSheetHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: _handelHeight,
      decoration: BoxDecoration(
          color: AppColors.contrastColor.withOpacity(0.75),
          borderRadius: BorderRadius.circular(_handelHeight)),
    );
  }
}
