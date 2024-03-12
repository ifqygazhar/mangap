import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/fetures/home/presentation/pages/home_page.dart';

import 'package:mangap/fetures/onboard/presentation/widgets/caraousel_widget.dart';
import 'package:mangap/core/constants/color.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.kPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CarouselWidget(),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Read Popular Komik",
                style: GoogleFonts.openSans(
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "We provide complete and popular manga updates faster than other apps",
                style: GoogleFonts.openSans(
                  color: ColorConstant.lightText,
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ButtonWidget(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  ),
                  color: ColorConstant.kThird,
                  text: "Get Started",
                  circular: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
