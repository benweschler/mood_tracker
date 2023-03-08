import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/data/entry_tag.dart';
import 'package:parchment/models/mood_entry_model.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/utils/iterable_utils.dart';
import 'package:parchment/widgets/buttons/action_button.dart';
import 'package:parchment/widgets/buttons/responsive_buttons.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Tags", style: TextStyles.heading),
              const SizedBox(height: Insets.med),
              Wrap(
                children: context
                    .select<MoodEntryModel, Iterable<EntryTag>>(
                        (model) => model.tags)
                    .map<Widget>((tag) => TagChip(tag))
                    .separate(const SizedBox(width: Insets.sm))
                    .toList(),
              ),
              const SizedBox(height: Insets.med),
              ActionButton(
                onTap: () => context.goNamed("logger"),
                color: AppColors.contrastColor,
                label: "Show Event Log",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final EntryTag tag;

  const TagChip(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.xs),
      decoration: BoxDecoration(
        color: AppColors.contrastColor.withOpacity(0.5),
        borderRadius: Corners.smBorderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            tag.icon,
            color: AppColors.contrastColor,
            size: TextStyles.caption.fontSize,
          ),
          const SizedBox(width: Insets.xs),
          Text(tag.label, style: TextStyles.caption),
        ],
      ),
    );
  }
}
