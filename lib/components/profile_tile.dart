import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/models/user_model.dart';
import 'package:learnify/providers/theme_provider.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({super.key, required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Image(image: image);
  }
}

class ProfilTile extends StatelessWidget {
  const ProfilTile({
    required this.data,
    required this.onPressedNotification,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final UserModel data;
  final Function() onPressedNotification;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: kSpacing / 2),
      decoration: BoxDecoration(
        color: (themeProvider.isDarkTheme)
            ? null
            : const Color.fromARGB(255, 65, 60, 110),
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kSpacing,
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(data.urlPhoto!),
          radius: 20,
          backgroundColor: Colors.white,
        ),
        title: Text(
          "${data.lastname} ${data.firstname![0]}.",
          style: TextStyle(fontSize: 14, color: kFontColorPallets[0]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          data.email!,
          style: TextStyle(fontSize: 12, color: kFontColorPallets[2]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          hoverColor: null,
          color: (themeProvider.isDarkTheme)
              ? null
              : const Color.fromARGB(255, 255, 255, 255),
          onPressed: onPressedNotification,
          icon: const Icon(EvaIcons.bellOutline),
          tooltip: "notification",
        ),
      ),
    );
  }
}
