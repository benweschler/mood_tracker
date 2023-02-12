import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:parchment/styles.dart';

const List<NavigationTab> _bottomNavigationTabs = [
  NavigationTab(
    rootLocation: "/",
    icon: Icons.home_max_rounded,
    label: "Home",
  ),
  NavigationTab(
    rootLocation: "/settings",
    icon: Icons.settings_rounded,
    label: "Settings",
  ),
];

class MainAppScaffold extends StatefulWidget {
  final Widget body;

  const MainAppScaffold({Key? key, required this.body}) : super(key: key);

  @override
  State<MainAppScaffold> createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  void _onItemTapped(BuildContext context, String rootLocation) {
    final location = GoRouter.of(context).location;
    if ((rootLocation != "/" || location == "/") &&
        location.startsWith(rootLocation)) return;
    context.go(rootLocation);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Column(
        children: [
          Expanded(child: Scaffold(body: widget.body)),
          // The navigation bar does not have a Scaffold, and therefore does not
          // have a DefaultTextStyle, as its ancestor, so provide one here.
          DefaultTextStyle(
            style: const TextStyle(),
            child: CustomNavigationBar(
              selectedRouteName: GoRouter.of(context).location,
              onTabTap: (rootLocation) => _onItemTapped(context, rootLocation),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  final String selectedRouteName;

  /// Returns the route path corresponding to the tapped tab.
  final ValueChanged<String> onTabTap;

  const CustomNavigationBar({
    Key? key,
    required this.selectedRouteName,
    required this.onTabTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(top: Insets.xs),
        child: Row(
          children: [
            for (var tab in _bottomNavigationTabs)
              Expanded(
                child: NavigationBarButton(
                  icon: tab.icon,
                  label: tab.label,
                  isActive: tab.rootLocation == selectedRouteName,
                  onTap: () {
                    onTabTap(tab.rootLocation);
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class NavigationBarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final GestureTapCallback onTap;

  const NavigationBarButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.red : IconTheme.of(context).color!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: color),
          Text(
            label,
            style: TextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationTab {
  final String rootLocation;
  final IconData icon;
  final String label;

  const NavigationTab({
    required this.rootLocation,
    required this.icon,
    required this.label,
  });
}
