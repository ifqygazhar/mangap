import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.textColor,
    this.heightImage = 240,
    this.widthImage = 240,
    this.textSize = 22,
    this.image = 'assets/images/kuru.gif',
    this.text = 'Lagi Memuat Komik...',
  });

  final Color textColor;
  final double heightImage;
  final double widthImage;
  final double textSize;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: widthImage,
            height: heightImage,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
            ),
          ),
        ],
      ),
    );
  }
}
