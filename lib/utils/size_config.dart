import 'dart:developer';

import 'package:flutter/widgets.dart';

class SizeConfig {
  late MediaQueryData _mediaQueryData;

  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  late double actualScreenHeight = 0.0;
  late double actualScreenWidth = 0.0;

  late double blockSizeHorizontal;
  late double blockSizeVertical;
  late double _safeAreaHorizontal;
  late double _safeAreaVertical;
  static double safeBlockHorizontal = 0.0;
  late double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    actualScreenHeight = screenHeight;
    actualScreenWidth = screenWidth;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    log(
      'Height : $actualScreenHeight',
      name: 'SizeConfig',
    );
    log(
      'Width : $actualScreenWidth',
      name: 'SizeConfig',
    );
  }
}
