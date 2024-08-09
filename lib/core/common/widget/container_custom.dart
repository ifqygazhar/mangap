import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerCustomWidget extends StatelessWidget {
  const ContainerCustomWidget({
    super.key,
    required this.containerColor,
    required this.title,
    required this.fontColor,
    this.marginRight = 0.0,
    this.marginLeft = 0.0,
    this.padding = 4.0,
    this.fontSize = 8.0,
  });

  final Color containerColor;
  final String title;
  final Color fontColor;
  final double marginRight;
  final double marginLeft;
  final double padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8,
        top: 8,
        right: marginRight,
        left: marginLeft,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: containerColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              color: fontColor,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
