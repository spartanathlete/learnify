import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/utils/strings.dart';

class WebScreenLayout extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final ThemeProvider themeProvider;

  const WebScreenLayout({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.themeProvider,
  });

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            leading: const CircleAvatar(
              backgroundImage: AssetImage(ImageRasterPath.avatar5),
              radius: 20,
              backgroundColor: Colors.white,
            ),
            groupAlignment: 0.0,
            selectedIndex: widget.selectedIndex,
            onDestinationSelected: widget.onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                label: Text(
                  (widget.themeProvider.lang == 'fr')
                      ? Strings.translations['nav_bar0']!['fr']!
                      : Strings.translations['nav_bar0']!['en']!,
                  style: TextStyle(
                    color: (widget.themeProvider.isDarkTheme)
                        ? null
                        : const Color.fromARGB(255, 186, 232, 232),
                  ),
                ),
                icon: Icon(
                  Icons.dashboard,
                  color: (widget.themeProvider.isDarkTheme)
                      ? null
                      : const Color.fromARGB(255, 186, 232, 232),
                ),
              ),
              NavigationRailDestination(
                label: Text(
                  (widget.themeProvider.lang == 'fr')
                      ? Strings.translations['nav_bar1']!['fr']!
                      : Strings.translations['nav_bar1']!['en']!,
                  style: TextStyle(
                    color: (widget.themeProvider.isDarkTheme)
                        ? null
                        : const Color.fromARGB(255, 186, 232, 232),
                  ),
                ),
                icon: Icon(
                  Icons.book,
                  color: (widget.themeProvider.isDarkTheme)
                      ? null
                      : const Color.fromARGB(255, 186, 232, 232),
                ),
              ),
              NavigationRailDestination(
                label: Text(
                  (widget.themeProvider.lang == 'fr')
                      ? Strings.translations['nav_bar2']!['fr']!
                      : Strings.translations['nav_bar2']!['en']!,
                  style: TextStyle(
                    color: (widget.themeProvider.isDarkTheme)
                        ? null
                        : const Color.fromARGB(255, 186, 232, 232),
                  ),
                ),
                icon: Icon(
                  Icons.settings,
                  color: (widget.themeProvider.isDarkTheme)
                      ? null
                      : const Color.fromARGB(255, 186, 232, 232),
                ),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: widget.body,
          ),
        ],
      ),
    );
  }
}
