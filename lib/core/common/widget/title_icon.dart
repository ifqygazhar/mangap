import 'package:flutter/material.dart';

class TitleIconWidget {
  static IconData getIcon(String title) {
    IconData icon;
    switch (title) {
      case "Popular Komik":
        icon = Icons.local_fire_department;

      case "Chapter Terbaru":
        icon = Icons.library_books;

      default:
        icon = Icons.post_add;
    }
    return icon;
  }
}
