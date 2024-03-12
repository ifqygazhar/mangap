import 'package:flutter/material.dart';
import 'package:mangap/core/constants/color.dart';

class TypeColor {
  static Color getColorType(String type) {
    Color color;
    switch (type) {
      case "Manga":
        color = const Color(0xFFB6002C);

      case "Manhwa":
        color = const Color(0xFF003274);

      default:
        color = const Color.fromARGB(255, 235, 235, 12);
    }
    return color;
  }

  static Color getTextColorType(String type) {
    Color textColor;
    switch (type) {
      case "Manga":
        textColor = ColorConstant.whiteColor;
      case "Manhwa":
        textColor = ColorConstant.whiteColor;
      default:
        textColor = ColorConstant.kThird;
    }
    return textColor;
  }
}
