import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/fetures/main/main_page.dart';

import 'package:mangap/fetures/onboard/presentation/widgets/caraousel_widget.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CarouselWidget(),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  "Baca Komik Populer",
                  style: GoogleFonts.openSans(
                    color: ColorConstant.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  "Kami menyediakan pembaruan manga yang lengkap dan populer lebih cepat daripada aplikasi lain",
                  style: GoogleFonts.openSans(
                    color: ColorConstant.lightText,
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: ButtonWidget(
                    icon: null,
                    onTap: () => _completeOnboarding(context),
                    color: ColorConstant.kThird,
                    text: "Ayo Mulai",
                    circular: 14,
                    foregroundColor: ColorConstant.whiteColor,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _completeOnboarding(BuildContext context) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('hasSeenOnboarding', true);

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => MainPage(),
    ),
  );
}
