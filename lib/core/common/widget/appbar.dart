import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstant.kThird,
      title: Text(
        title,
        style: GoogleFonts.openSans(
          color: ColorConstant.whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      iconTheme: const IconThemeData(
        color: ColorConstant.whiteColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
