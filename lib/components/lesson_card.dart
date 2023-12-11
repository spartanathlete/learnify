import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/models/lesson_model.dart';
import 'package:learnify/models/user_model.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/components/list_profil_image.dart';
import 'package:learnify/screens/lesson/lesson_screen.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    required this.data,
    // required this.onPressedMore,
    required this.onPressedTask,
    required this.onPressedExercise,
    required this.onPressedPursue,
    Key? key,
    required this.themeProvider,
    required this.user,
  }) : super(key: key);

  final LessonModel data;
  final Future<UserModel?> user;
  final ThemeProvider themeProvider;

  // final Function() onPressedMore;
  final Function() onPressedTask;
  final Function() onPressedExercise;
  final Function() onPressedPursue;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: _Tile(
                themeProvider: themeProvider,
                dotColor: Colors.amber[700]!,
                title: data.title!,
                subtitle: data.subTitle!,
                onPressedMore: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          LessonScreen(lessonData: data, user: user),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.amber[700]!,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: onPressedTask,
                    child: Text(
                      data.type!,
                    ),
                  ),
                  ListProfilImage(
                    images: const [
                      AssetImage(ImageRasterPath.avatar1),
                      AssetImage(ImageRasterPath.avatar2),
                      AssetImage(ImageRasterPath.avatar3),
                      AssetImage(ImageRasterPath.avatar4),
                    ],
                    onPressed: onPressedExercise,
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSpacing / 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
              child: Row(
                children: [
                  _IconButton(
                    iconData: Icons.more_outlined,
                    onPressed: onPressedPursue,
                    label: "Pursue",
                    themeProvider: themeProvider,
                  ),
                  const SizedBox(width: kSpacing / 2),
                  _IconButton(
                    iconData: Icons.more_outlined,
                    onPressed: onPressedExercise,
                    label: "Exercise",
                    themeProvider: themeProvider,
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSpacing / 2),
          ],
        ),
      ),
    );
  }
}

/* -----------------------------> COMPONENTS <------------------------------ */
class _Tile extends StatelessWidget {
  const _Tile({
    required this.dotColor,
    required this.title,
    required this.subtitle,
    required this.onPressedMore,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final Color dotColor;
  final String title;
  final String subtitle;
  final Function() onPressedMore;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _dot(dotColor),
              const SizedBox(width: 8),
              Expanded(child: _title(title, themeProvider)),
              _moreButton(
                onPressed: onPressedMore,
                themeProvider: themeProvider,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _subtitle(context, subtitle, themeProvider),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _dot(Color color) {
    return CircleAvatar(
      radius: 4,
      backgroundColor: color,
    );
  }

  Widget _title(String data, ThemeProvider provider) {
    return Text(
      style: (provider.isDarkTheme)
          ? null
          : const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      data,
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _subtitle(BuildContext context, String data, ThemeProvider provider) {
    return Text(
      style: (provider.isDarkTheme)
          ? Theme.of(context).textTheme.bodySmall
          : const TextStyle(color: Color.fromRGBO(210, 210, 210, 1)),
      data,
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _moreButton({
    required Function() onPressed,
    required themeProvider,
  }) {
    return IconButton(
      color: (themeProvider.isDarkTheme)
          ? null
          : const Color.fromARGB(255, 255, 255, 255),
      iconSize: 20,
      onPressed: onPressed,
      icon: const Icon(Icons.more_vert_rounded),
      splashRadius: 20,
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.iconData,
    required this.label,
    required this.onPressed,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final IconData iconData;
  final String label;
  final Function() onPressed;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: (themeProvider.isDarkTheme)
            ? Colors.transparent
            : const Color.fromARGB(71, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
      onPressed: onPressed,
      icon: _icon(iconData, themeProvider),
      label: _label(label, themeProvider),
    );
  }

  Widget _label(String data, ThemeProvider provider) {
    return Text(
      style: (provider.isDarkTheme)
          ? const TextStyle(
              color: Colors.white54,
              fontSize: 10,
            )
          : const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      data,
    );
  }

  Widget _icon(IconData iconData, ThemeProvider provider) {
    return Icon(
      iconData,
      color: (provider.isDarkTheme)
          ? const Color.fromARGB(255, 255, 255, 255)
          : Colors.white54,
      size: 14,
    );
  }
}
