import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';

class KomikGenreWidgetHome extends StatelessWidget {
  const KomikGenreWidgetHome({
    super.key,
    required this.title,
    required this.href,
  });

  final String title;
  final String href;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 3, top: 8),
      decoration: BoxDecoration(
        color: ColorConstant.kThird,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: GoogleFonts.openSans(
            color: ColorConstant.whiteColor,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
