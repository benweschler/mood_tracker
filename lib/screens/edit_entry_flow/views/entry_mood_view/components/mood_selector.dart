import 'package:flutter/material.dart';
import 'package:parchment/constants.dart';
import 'package:parchment/theme.dart';
import 'package:parchment/utils/color_utils.dart';
import 'package:parchment/widgets/custom_slider.dart';
import 'package:parchment/widgets/outlined_text.dart';

class MoodSelector extends StatelessWidget {
  final int mood;
  final ValueChanged<int> onMoodChanged;

  const MoodSelector({
    Key? key,
    required this.mood,
    required this.onMoodChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedText(
          "${mood % 1 == 0 ? mood.toInt() : mood}",
          strokeColor: AppColors.contrastColor,
          strokeWidth: 2,
          style: TextStyle(
            fontSize: 175,
            color: colorFromMood(mood),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Insets.sm),
        CustomSlider(
          value: mood / Constants.maxMood,
          trackColor: colorFromMood(mood),
          borderColor: AppColors.contrastColor,
          divisions: Constants.maxMood.toInt(),
          onChanged: (value) {
            onMoodChanged(
              (value * Constants.maxMood).toInt(),
            );
          },
        ),
      ],
    );
  }
}
