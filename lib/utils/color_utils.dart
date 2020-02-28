import 'package:flutter/material.dart';

class ColorUtils {
  static Color getColorFromCode(String code) {
    String colorCode = '0xFF' + code.replaceAll("#", "");
    return Color(int.parse(colorCode));
  }
}
