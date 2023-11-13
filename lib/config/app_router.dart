import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify/screens/exercice/exercice_screen.dart';
import 'package:learnify/screens/home/home_screen.dart';
import 'package:learnify/screens/lessons_overview/lesson_overview_screen.dart';
import 'package:learnify/screens/settings/settings_screen.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/responsive/responsive_layout.dart';
import 'package:learnify/utils/size_config.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static final _shellNavHomeKey = GlobalKey<NavigatorState>();
  static final _shellNavLessonsKey = GlobalKey<NavigatorState>();
  static final _shellNavSettingsKey = GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    navigatorKey: Get.key,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          var themeProvider = Provider.of<ThemeProvider>(context);
          return ResponsiveLayout(
            themeProvider: themeProvider,
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavHomeKey,
            routes: [
              GoRoute(
                path: '/',
                name: 'home',
                builder: (context, state) {
                  var themeProvider = Provider.of<ThemeProvider>(context);
                  var sizeConfig = SizeConfig()..init(context);
                  return HomeScreen(
                    sizeConfig: sizeConfig,
                    themeProvider: themeProvider,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavLessonsKey,
            routes: [
              GoRoute(
                path: '/lessons',
                name: 'lessons',
                builder: (context, state) {
                  var themeProvider = Provider.of<ThemeProvider>(context);
                  return LessonOverviewScreen(
                    themeProvider: themeProvider,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'exercise',
                    name: 'exercise',
                    builder: (context, state) {
                      final String? lessonName = state.extra as String?;
                      if (lessonName != null) {
                        return ExerciceScreen(lessonName: lessonName);
                      } else {
                        return const ExerciceScreen(lessonName: "Not sent");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          // StatefulShellBranch(
          //   navigatorKey: _shellNavExerciseKey,
          //   routes: [
          //     GoRoute(
          //       path: '/exercise',
          //       name: 'exercise',
          //       builder: (context, state) {
          //         return const ExerciceScreen();
          //       },
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            navigatorKey: _shellNavSettingsKey,
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) {
                  var themeProvider = Provider.of<ThemeProvider>(context);
                  return SettingsScreen(
                    themeProvider: themeProvider,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
