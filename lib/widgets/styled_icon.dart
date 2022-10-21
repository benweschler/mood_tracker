import 'package:flutter/widgets.dart';

/// An icon with a circular decoration.
class StyledIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const StyledIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Icon(icon, color: color),
    );
  }
}
