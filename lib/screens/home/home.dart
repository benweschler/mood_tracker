import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/styles.dart';
import 'package:parchment/widgets/animations/transitions.dart';
import 'package:parchment/widgets/buttons/action_button.dart';
import 'package:parchment/widgets/buttons/responsive_buttons.dart';
import 'package:parchment/widgets/custom_scaffold.dart';

import 'components/calendar_view.dart';
import 'components/timeline_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController();
  double _page = 0;

  @override
  void initState() {
    _controller.addListener(updatePage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(updatePage);
    _controller.dispose();
    super.dispose();
  }

  /// Updates [_page] with the current page.
  ///
  /// Only fires when the controller is updated to avoid accessing the
  /// controller before the PageView is built.
  void updatePage() => setState(() => _page = _controller.page!);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      center: CenterHeading(page: _page),
      trailing: ResponsiveStrokeButton(
        onTap: () => context.pushNamed("settings"),
        child: const Icon(
          Icons.settings_rounded,
          color: AppColors.contrastColor,
        ),
      ),
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
      onTap: () => context.goNamed("edit-entry"),
      label: "Add Entry",
      icon: Icons.add_rounded,
    );
  }
}

class CenterHeading extends StatelessWidget {
  final double page;

  const CenterHeading({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CrossFadeOpacity(
      firstChild: const Text("Mood Timeline", style: TextStyles.title),
      secondChild: const Text("Calendar", style: TextStyles.title),
      position: page,
    );
  }
}
