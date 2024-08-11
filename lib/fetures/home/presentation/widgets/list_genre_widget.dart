import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mangap/core/common/widget/title_icon.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/presentation/widgets/genre_komik_widget.dart';

import 'package:mangap/fetures/home/domain/entities/komik_genre.dart';

class ListGenreWidget extends StatelessWidget {
  const ListGenreWidget({
    super.key,
    required this.title,
    required this.genres,
  });

  final String title;
  final List<KomikGenreEntity> genres;

  @override
  Widget build(BuildContext context) {
    IconData icon = TitleIconWidget.getIcon(title);
    return Column(
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
          height: 400,
          child: ListView.builder(
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              return KomikGenreWidgetHome(
                title: genre.title,
                href: genre.href,
              );
            },
          ),
        ),
      ],
    );
  }
}
