import 'package:flutter/material.dart';
import 'package:mood_tracker/theme.dart';
import 'package:mood_tracker/utils/iterable_utils.dart';
import 'package:mood_tracker/widgets/buttons/responsive_button.dart';

import 'modal_sheet.dart';

class ContextMenu extends StatelessWidget {
  final List<ContextMenuAction> actions;

  const ContextMenu({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[...actions].separate(const Divider()).toList(),
        ),
      ),
    );
  }
}

class ContextMenuAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final GestureTapCallback? onTap;

  const ContextMenuAction({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveButton.dark(
      onTap: onTap,
      builder: (overlayColor) => Container(
        color: overlayColor,
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.offset,
          vertical: Insets.lg,
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: Insets.lg),
            Expanded(
              child: Text(
                label,
                style: TextStyles.title.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
