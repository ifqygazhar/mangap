import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
    required this.circular,
    required this.foregroundColor,
    required this.fontSize,
    required this.icon,
    this.isIcon = false,
  });

  final Function() onTap;
  final Color color;
  final String text;
  final double circular;
  final Color foregroundColor;
  final double? fontSize;
  final Icon? icon;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return isIcon == false
        ? ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                foregroundColor: foregroundColor,
                backgroundColor: color,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(circular),
                )),
            child: Text(
              text,
              style: GoogleFonts.openSans(fontSize: fontSize),
            ),
          )
        : ElevatedButton.icon(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              foregroundColor: foregroundColor,
              backgroundColor: color,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circular),
              ),
            ),
            icon: icon,
            label: Text(
              text,
              style: GoogleFonts.openSans(fontSize: fontSize),
            ),
          );
  }
}
