import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.rating});

  final double rating;

  @override
  Row build(BuildContext context) {
    double value = rating / 2;
    int fullStars = value.floor();
    bool hasHalfStar = value - fullStars >= 0.5;

    return Row(
      children: List.generate(
        5,
        (index) {
          if (index < fullStars) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            );
          } else if (index == fullStars && hasHalfStar) {
            return const Icon(
              Icons.star_half,
              color: Colors.amber,
              size: 16,
            );
          } else {
            return const Icon(
              Icons.star_border,
              color: Colors.amber,
              size: 16,
            );
          }
        },
      ),
    );
  }
}

String fixedRating(String strRating) {
  String formattedRate =
      strRating == "?" ? "0.00" : strRating.replaceAll(',', '.');
  double rating = double.tryParse(formattedRate) ?? 0.00;

  return rating.toString();
}
