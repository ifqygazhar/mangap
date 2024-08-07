import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mangap/core/common/widget/title_icon.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/domain/entities/komik_popular_entity.dart';
import 'package:mangap/fetures/home/presentation/widgets/popular_komik_widget.dart';

class ListPopularWidget extends StatelessWidget {
  const ListPopularWidget(
      {super.key, required this.title, required this.komiks});

  final String title;
  final List<KomikPopularEntity> komiks;

  @override
  Widget build(BuildContext context) {
    IconData icon = TitleIconWidget.getIcon(title);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
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
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 420,
            child: ListView.builder(
              itemCount: komiks.length,
              itemBuilder: (context, index) {
                final komik = komiks[index];
                return PopularKomikWidget(
                  title: komik.title,
                  href: komik.href,
                  genre: komik.genre,
                  year: komik.year,
                  thumbnail: komik.thumbnail,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
