import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'ifqygazhar@gmail.com',
      query:
          'subject=Saran%20dan%20Masukan&body=Halo,', // Subject dan body optional
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tidak dapat membuka email"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Info'),
      backgroundColor: ColorConstant.kPrimary,
      body: Column(
        children: [
          Container(
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
                    text: "Aplikasi ini di develop oleh ",
                    style: GoogleFonts.openSans(
                      color: ColorConstant.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: "@ifqygazhar ",
                    style: GoogleFonts.openSans(
                      color: ColorConstant.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "jika ada bug atau saran dan masukan bisa email ke ",
                    style: GoogleFonts.openSans(
                      color: ColorConstant.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchEmail(context);
                      },
                    text: "ifqygazhar@gmail.com. ",
                    style: GoogleFonts.openSans(
                      color: ColorConstant.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Aplikasi ini tidak akan ada iklan selamanya dari saya untuk kalian yang senang membaca komik.",
                    style: GoogleFonts.openSans(
                      color: ColorConstant.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorConstant.kThird,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  "V 1.3.0",
                  style: GoogleFonts.openSans(
                    color: ColorConstant.whiteColor,
                    fontSize: 18,
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
