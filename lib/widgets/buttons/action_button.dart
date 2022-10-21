import 'package:flutter/material.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/widgets/buttons/responsive_button.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final GestureTapCallback onTap;

  final IconData? icon;

  const ActionButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.label,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveButton.light(
      onTap: onTap,
      builder: (overlayColor) {
        return Container(
          padding: const EdgeInsets.all(Insets.med),
          decoration: BoxDecoration(
            color: Color.alphaBlend(overlayColor, color),
            borderRadius: Corners.medBorderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyles.title.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: Insets.sm),
                Icon(icon, color: Theme.of(context).scaffoldBackgroundColor),
              ]
            ],
          ),
        );
      },
    );
  }
}
