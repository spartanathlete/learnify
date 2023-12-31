import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';

class GetPremiumCard extends StatelessWidget {
  const GetPremiumCard({
    required this.onPressed,
    this.backgroundColor,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final Color? backgroundColor;
  final Function() onPressed;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(kBorderRadius),
      color: backgroundColor ?? Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: onPressed,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 250,
            maxWidth: 350,
            minHeight: 200,
            maxHeight: 200,
          ),
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  ImageVectorPath.wavyBus,
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get\nPremium\nAccount",
                      style: TextStyle(
                        color: (themeProvider.isDarkTheme)
                            ? null
                            : const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "To add more members",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: (themeProvider.isDarkTheme)
                                ? null
                                : const Color.fromARGB(255, 255, 255, 255),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
