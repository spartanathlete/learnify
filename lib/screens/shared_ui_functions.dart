import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:learnify/components/profile_tile.dart';
import 'package:learnify/components/search_field.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/controllers/data_controller.dart';
import 'package:learnify/models/profile.dart';
import 'package:learnify/providers/theme_provider.dart';

class SharedUiFunctions {
  DashboardController controller = DashboardController();

  Widget buildHeader({Function()? onPressedMenu, themeProvider}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          if (onPressedMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: kSpacing),
              child: IconButton(
                onPressed: onPressedMenu,
                icon: const Icon(EvaIcons.menu),
                tooltip: "menu",
              ),
            ),
          Expanded(child: SearchField(themeProvider: themeProvider)),
        ],
      ),
    );
  }

  Widget buildProfile({
    required Profile data,
    required ThemeProvider themeProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: ProfilTile(
        themeProvider: themeProvider,
        data: controller.getProfiles()[1],
        onPressedNotification: () {},
      ),
    );
  }
}
