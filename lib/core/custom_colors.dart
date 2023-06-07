import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color appGrey1 = fromHex('#707070');

  static Color appBlueGrey1 = fromHex('#99fafafa');

  static Color appGrey2 = fromHex('#b7b7b7');

  static Color appGrey3 = fromHex('#848fac');

  static Color appgrey4 = fromHex('#111111');

  static Color appGrey5 = fromHex('#262626');

  static Color appGrey6 = fromHex('#e7e7e7');

  static Color appGrey7 = fromHex('#fafafa');

  static Color appGrey8 = fromHex('#f3f3f3');

  static Color appBlack1 = fromHex('#66000000');

  static Color appBlack2 = fromHex('#000000');

  static Color appGrey9 = fromHex('#eff3fa');

  static Color appGrey10 = fromHex('#99f3f3f3');

  static Color primaryColor = fromHex('#896621');

  static Color primaryColor2 = fromHex('#CF7C68');

  static Color appBlueGrey2 = fromHex('#2d2d2d');

  static Color appGrey11 = fromHex('#888888');

  static Color appGrey12 = fromHex('#90111111');

  static Color appWhite1 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
