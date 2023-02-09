import 'package:flutter/material.dart';
import 'package:parchment/data/logger.dart';
import 'package:parchment/screens/edit_entry_flow/edit_entry_wrapper.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/utils/iterable_utils.dart';
import 'package:parchment/utils/navigation_utils.dart';
import 'package:parchment/widgets/buttons/action_button.dart';
import 'package:parchment/widgets/buttons/responsive_button.dart';
import 'package:parchment/widgets/custom_scaffold.dart';
import 'package:parchment/widgets/styled_icon.dart';

import 'components/calendar_view.dart';
import 'components/timeline_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomActionButton: const _EntryActionButton(),
      addBorderInsets: false,
      child: PageView(
        controller: _controller,
        children: const [
          TimelineView(),
          CalendarView(),
        ],
      ),
    );
  }
}

class _EntryActionButton extends StatelessWidget {
  const _EntryActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      color: AppColors.contrastColor,
      onTap: () => context.push(
        const EditEntryWrapper(),
        fullscreenDialog: true,
      ),
      label: "Add Entry",
      icon: Icons.add_rounded,
    );
  }
}

class LoggerView extends StatelessWidget {
  const LoggerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: ResponsiveStrokeButton(
        onTap: () => context.pop(rootNavigator: true),
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
