import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/utils/strings.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
    this.onSearch,
    required this.themeProvider,
  }) : super(key: key);

  final controller = TextEditingController();
  final Function(String value)? onSearch;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                DateFormat.yMMMEd().format(DateTime.now()),
              )
            ],
          ),
        ),
        const SizedBox(width: kSpacing),
        Expanded(
            child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            hintStyle: TextStyle(
              color: (themeProvider.isDarkTheme)
                  ? const Color.fromRGBO(170, 170, 170, 1)
                  : kFontColorPallets[1],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(EvaIcons.search),
            hintText: (themeProvider.lang == 'fr')
                ? Strings.translations['search0']!['fr']!
                : Strings.translations['search0']!['en']!,
            isDense: true,
            fillColor: Theme.of(context).cardColor,
          ),
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
            if (onSearch != null) onSearch!(controller.text);
          },
          textInputAction: TextInputAction.search,
          style: TextStyle(
            color: (themeProvider.isDarkTheme)
                ? Colors.white
                : kFontColorPallets[1],
          ),
        )),
      ],
    );
  }
}
