import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
    required this.circular,
  });

  final Function() onTap;
  final Color color;
  final String text;
  final double circular;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          foregroundColor: ColorConstant.whiteColor,
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circular),
          )),
      child: Text(
        text,
        style: GoogleFonts.openSans(fontSize: 18),
      ),
    );
  }
}
