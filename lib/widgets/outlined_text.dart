import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final Color strokeColor;
  final double strokeWidth;
  final TextStyle style;

  const OutlinedText(
      this.text, {
        Key? key,
        required this.strokeColor,
        required this.strokeWidth,
        required this.style,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            color: null,
            foreground: Paint()
              ..style = PaintingStyle.stroke
            // Half of the stroke is obscured by the background.
              ..strokeWidth = strokeWidth * 2
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          style: style.copyWith(
            // Ensure that the stroke is limited to the border of the text by
            // obscuring the interior of the text with an opaque color.
            color: Color.alphaBlend(
              style.color ?? Colors.transparent,
              Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}