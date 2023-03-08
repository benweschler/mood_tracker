import 'package:flutter/material.dart';
import 'package:parchment/data/logger.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/utils/iterable_utils.dart';
import 'package:parchment/widgets/buttons/responsive_buttons.dart';
import 'package:parchment/widgets/custom_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/widgets/styled_icon.dart';

class LoggerView extends StatelessWidget {
  const LoggerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: ResponsiveStrokeButton(
        onTap: context.pop,
        child: const StyledIcon(
          icon: Icons.arrow_back_rounded,
          color: AppColors.contrastColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Event Log", style: TextStyles.heading),
          const SizedBox(height: Insets.lg),
          ...Logger.dump
              .map<Widget>((log) => Text(log))
              .separate(const SizedBox(height: Insets.med))
              .toList()
        ],
      ),
    );
  }
}
