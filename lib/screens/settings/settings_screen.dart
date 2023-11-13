import 'package:flutter/material.dart';
import 'package:learnify/components/custom_list_tile.dart';
import 'package:learnify/controllers/data_controller.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/components/responsive_builder.dart';
import 'package:learnify/utils/strings.dart';

class SettingsScreen extends StatefulWidget {
  final ThemeProvider themeProvider;

  const SettingsScreen({
    super.key,
    required this.themeProvider,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final DashboardController controller = DashboardController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobileBuilder: ((context, constraints) => mob()),
      tabletBuilder: ((context, constraints) => tab()),
      desktopBuilder: (context, constraints) => SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 800),
            child: ListView(
              children: [
                SingleSection(
                  title: (widget.themeProvider.lang == 'fr')
                      ? Strings.translations['set0']!['fr']!
                      : Strings.translations['set0']!['en']!,
                  children: [
                    GestureDetector(
                      onTapDown: (details) {
                        if (widget.themeProvider.isDarkTheme) {
                          widget.themeProvider.setDarkTheme = false;
                        } else {
                          widget.themeProvider.setDarkTheme = true;
                        }
                      },
                      child: CustomListTile(
                        title: (widget.themeProvider.lang == 'fr')
                            ? Strings.translations['set1']!['fr']!
                            : Strings.translations['set1']!['en']!,
                        icon: (widget.themeProvider.isDarkTheme)
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (details) {
                        if (widget.themeProvider.lang == 'fr') {
                          widget.themeProvider.setLang = 'en';
                        } else {
                          widget.themeProvider.setLang = 'fr';
                        }
                      },
                      child: CustomListTile(
                        title: (widget.themeProvider.lang == 'fr')
                            ? "${Strings.translations['set2']!['fr']!} (Français)"
                            : "${Strings.translations['set2']!['en']!} (English)",
                        icon: Icons.language_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mob() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 800),
            child: ListView(
              children: [
                SingleSection(
                  title: (widget.themeProvider.lang == 'fr')
                      ? Strings.translations['set0']!['fr']!
                      : Strings.translations['set0']!['en']!,
                  children: [
                    GestureDetector(
                      onTapDown: (details) {
                        if (widget.themeProvider.isDarkTheme) {
                          widget.themeProvider.setDarkTheme = false;
                        } else {
                          widget.themeProvider.setDarkTheme = true;
                        }
                      },
                      child: CustomListTile(
                        title: (widget.themeProvider.lang == 'fr')
                            ? Strings.translations['set1']!['fr']!
                            : Strings.translations['set1']!['en']!,
                        icon: (widget.themeProvider.isDarkTheme)
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (details) {
                        if (widget.themeProvider.lang == 'fr') {
                          widget.themeProvider.setLang = 'en';
                        } else {
                          widget.themeProvider.setLang = 'fr';
                        }
                      },
                      child: CustomListTile(
                        title: (widget.themeProvider.lang == 'fr')
                            ? "${Strings.translations['set2']!['fr']!} (Français)"
                            : "${Strings.translations['set2']!['en']!} (English)",
                        icon: Icons.language_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tab() {
    return const Center(
      child: Text('tab'),
    );
  }
}
