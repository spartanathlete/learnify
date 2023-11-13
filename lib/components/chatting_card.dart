import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';

class ChattingCardData {
  final ImageProvider image;
  final bool isOnline;
  final String name;
  final String lastMessage;
  final bool isRead;
  final int totalUnread;

  const ChattingCardData({
    required this.image,
    required this.isOnline,
    required this.name,
    required this.lastMessage,
    required this.isRead,
    required this.totalUnread,
  });
}

class ChattingCard extends StatelessWidget {
  const ChattingCard({
    required this.data,
    required this.onPressed,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final ChattingCardData data;
  final Function() onPressed;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: kSpacing / 2),
          decoration: BoxDecoration(
            color: (themeProvider.isDarkTheme)
                ? null
                : const Color.fromARGB(255, 65, 60, 110),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: kSpacing,
                ),
                leading: Stack(
                  children: [
                    CircleAvatar(backgroundImage: data.image),
                    CircleAvatar(
                      backgroundColor:
                          data.isOnline ? Colors.green : Colors.grey,
                      radius: 5,
                    ),
                  ],
                ),
                title: Text(
                  data.name,
                  style: TextStyle(fontSize: 13, color: kFontColorPallets[0]),
                ),
                subtitle: Text(
                  data.lastMessage,
                  style: TextStyle(
                    fontSize: 11,
                    color: kFontColorPallets[2],
                  ),
                ),
                onTap: onPressed,
                trailing: (!data.isRead && data.totalUnread > 1)
                    ? _notif(context, data.totalUnread)
                    : Icon(
                        Icons.check,
                        color: data.isRead ? Colors.grey : Colors.green,
                      ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _notif(BuildContext context, int total) {
    return Container(
      width: 30,
      height: 30,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: (themeProvider.isDarkTheme)
            ? Colors.white
            : const Color.fromARGB(255, 151, 166, 190),
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: Text(
        (total >= 100) ? "99+" : "$total",
        style: TextStyle(
          color: (themeProvider.isDarkTheme)
              ? const Color.fromARGB(255, 0, 0, 0)
              : Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
