import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitleIconWidget {
  static IconData getIcon(String title) {
    IconData icon;
    switch (title) {
      case "Popular Komik":
        icon = FontAwesomeIcons.fire;

      case "Genre":
        icon = FontAwesomeIcons.yinYang;

      default:
        icon = FontAwesomeIcons.solidThumbsUp;
    }
    return icon;
  }
}
