import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';

class KomikDescriptionWidget extends StatelessWidget {
  const KomikDescriptionWidget({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstant.kThird,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: GoogleFonts.openSans(
                color: ColorConstant.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: GoogleFonts.openSans(
                color: ColorConstant.lightText,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
