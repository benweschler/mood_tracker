import 'package:flutter/material.dart';
import 'package:mood_tracker/theme.dart';

class StyledIconButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback? onTap;

  const StyledIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.contrastColor,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: AppColors.contrastColor,
        ),
      ),
    );
  }
}
