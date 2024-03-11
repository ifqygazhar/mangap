import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/fetures/home/presentation/pages/home_page.dart';

import 'package:mangap/fetures/onboard/presentation/widgets/caraousel_widget.dart';
import 'package:mangap/core/constants/color.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
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
                  color: Colors.white,
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
                  color: lightText,
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
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: kThird,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      )),
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.openSans(fontSize: 18),
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
