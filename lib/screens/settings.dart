import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/data/entry_tag.dart';
import 'package:parchment/models/mood_entry_model.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/widgets/buttons/responsive_button.dart';
import 'package:parchment/widgets/custom_scaffold.dart';
import 'package:parchment/widgets/styled_icon.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: ResponsiveStrokeButton(
        onTap: context.pop,
        child: const StyledIcon(
          icon: Icons.arrow_back,
          color: AppColors.contrastColor,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _ShowEventLogButton(),
              ...context
                  .select<MoodEntryModel, Iterable<EntryTag>>(
                      (model) => model.tags)
                  .map((tag) => Text(tag.label))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShowEventLogButton extends StatelessWidget {
  const _ShowEventLogButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveStrokeButton(
      onTap: () => context.goNamed("logger"),
      child: const StyledIcon(
        icon: Icons.timeline,
        color: AppColors.contrastColor,
      ),
    );
  }
}
