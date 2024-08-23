import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({super.key, required this.konteks});

  final String konteks;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.kThird,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Perhatian, data $konteks yang disimpan bersifat ",
                  style: GoogleFonts.openSans(
                    color: ColorConstant.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: "LOCAL ",
                  style: GoogleFonts.openSans(
                    color: ColorConstant.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "jadi kalau aplikasi nya dihapus atau di uninstall maka data nya akan hilang.",
                  style: GoogleFonts.openSans(
                    color: ColorConstant.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text:
                      " Untuk menghapus tiap $konteks tinggal geser ke kiri !.",
                  style: GoogleFonts.openSans(
                    color: ColorConstant.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
