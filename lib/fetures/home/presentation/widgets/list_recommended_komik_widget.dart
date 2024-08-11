import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mangap/core/common/widget/title_icon.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/domain/entities/komik_recommended_entity.dart';
import 'package:mangap/fetures/home/presentation/widgets/recommended_komik_card_widget.dart';

class ListRecommendedKomikWidget extends StatelessWidget {
  const ListRecommendedKomikWidget({
    super.key,
    required this.title,
    required this.komiks,
  });

  final String title;
  final List<KomikRecommendedEntity> komiks;

  @override
  Widget build(BuildContext context) {
    IconData icon = TitleIconWidget.getIcon(title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(
              icon,
              color: ColorConstant.whiteColor,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              title,
              style: const TextStyle(
                color: ColorConstant.whiteColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 420,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: komiks.length,
            itemBuilder: (context, index) {
              final komik = komiks[index];
              String formattedRate = komik.rating == "?"
                  ? "0.00"
                  : komik.rating.replaceAll(',', '.');
              double rating = double.tryParse(formattedRate) ?? 0.00;
              return Padding(
                padding: const EdgeInsets.only(right: 16, top: 8.0),
                child: RecommendedKomikCardWidget(
                  thumbnail: komik.thumbnail,
                  title: komik.title,
                  chapter: komik.chapter,
                  rating: rating.toString(),
                  type: komik.type,
                  href: komik.href,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
