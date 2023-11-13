import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/responsive/mobile_screen_layout.dart';
import 'package:learnify/responsive/web_screen_layout.dart';

class ResponsiveLayout extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final ThemeProvider themeProvider;

  const ResponsiveLayout({
    super.key,
    required this.navigationShell,
    required this.themeProvider,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileScreenLayout(
            themeProvider: widget.themeProvider,
            body: widget.navigationShell,
            selectedIndex: widget.navigationShell.currentIndex,
            onDestinationSelected: _goBranch,
          );
        }
        return WebScreenLayout(
          themeProvider: widget.themeProvider,
          body: widget.navigationShell,
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      },
    );
  }

  void _goBranch(int index) {
    print('index : $index');
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
