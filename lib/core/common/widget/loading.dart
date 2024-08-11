import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.textColor,
    this.heightImage = 240,
    this.widthImage = 240,
    this.textSize = 22,
  });

  final Color textColor;
  final double heightImage;
  final double widthImage;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/kuru.gif',
            width: widthImage,
            height: heightImage,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Loading Please Wait',
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
