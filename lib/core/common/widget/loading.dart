import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.textColor});

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/kuru.gif',
            width: 240,
            height: 240,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Loading Please Wait',
            style: TextStyle(
              color: textColor,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
