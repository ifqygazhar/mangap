import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';

class InformationFullscreen extends StatelessWidget {
  const InformationFullscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.kThird,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Ketuk 2x Layar Untuk Kembali dari Mode ",
              style: GoogleFonts.openSans(
                color: ColorConstant.whiteColor,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            TextSpan(
              text: "Fullscreen",
              style: GoogleFonts.openSans(
                color: ColorConstant.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: " ,dan untuk zoom gambar bisa strecth menggunakan 2 jari.",
              style: GoogleFonts.openSans(
                color: ColorConstant.whiteColor,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
