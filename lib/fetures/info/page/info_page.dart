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

  Future<void> _launchBrowser(
      BuildContext context, String host, String path) async {
    final Uri emailUri = Uri(scheme: 'https', host: host, path: path);

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(
        emailUri,
        mode: LaunchMode.inAppWebView,
        browserConfiguration: const BrowserConfiguration(showTitle: true),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tidak dapat membuka email"),
        ),
      );
    }
  }

  Future<void> _launchFb() async {
    const String fbProtocolUrl = 'fb://page/61565055713502';

    String fallbackUrl = 'https://www.facebook.com/Mangapp-61565055713502';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  Future<void> _launchChrome(String URI) async {
    final String url = URI;

    try {
      await launch(url, forceSafariVC: false);
    } catch (e) {
      await launch(url, forceSafariVC: false);
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
          _buildTapSupportSocial(
            context,
            () => _launchBrowser(
              context,
              'github.com',
              '/manggap/mangapp_public',
            ),
            'V 1.3.1',
            ColorConstant.kThird,
            ColorConstant.whiteColor,
            const Icon(
              Icons.verified,
              color: ColorConstant.whiteColor,
            ),
          ),
          _buildTapSupportSocial(
            context,
            () => _launchChrome('https://saweria.co/ifqygazhar'),
            'Saweria',
            const Color(0xFFFAAE31),
            Colors.black,
            const Icon(Icons.attach_money),
          ),
          _buildTapSupportSocial(
            context,
            () => _launchFb(),
            'Facebook',
            Colors.blueAccent,
            ColorConstant.whiteColor,
            const Icon(
              Icons.facebook,
              color: ColorConstant.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildTapSupportSocial(
    BuildContext context,
    Function()? onTap,
    String title,
    Color containerColor,
    Color textColor,
    Icon icon,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: GoogleFonts.openSans(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
