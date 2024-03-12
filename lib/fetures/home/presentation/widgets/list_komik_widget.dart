import 'package:flutter/material.dart';
import 'package:mangap/core/common/widget/title_icon.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';
import 'package:mangap/fetures/home/presentation/widgets/hot_komik_card_widget.dart';

class ListKomikWidget extends StatelessWidget {
  const ListKomikWidget({super.key, required this.title, required this.komiks});

  final String title;
  final List<KomikEntity> komiks;

  @override
  Widget build(BuildContext context) {
    IconData icon = TitleIconWidget.getIcon(title);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: ColorConstant.whiteColor,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: ColorConstant.whiteColor, fontSize: 20),
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
                return Padding(
                  padding: const EdgeInsets.only(right: 16, top: 8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: HotKomikCardWidget(
                      coverImg: komik.coverImg,
                      title: komik.title,
                      chapter: komik.latestChapter,
                      rating: komik.rating,
                      type: komik.type,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
