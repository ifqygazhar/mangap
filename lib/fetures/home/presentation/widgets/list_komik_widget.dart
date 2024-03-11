import 'package:flutter/material.dart';
import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';
import 'package:mangap/fetures/home/presentation/widgets/hot_komik_card_widget.dart';

class ListKomikWidget extends StatelessWidget {
  const ListKomikWidget({super.key, required this.title, required this.komiks});

  final String title;
  final List<KomikEntity> komiks;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (title) {
      case "Popular Komik":
        icon = Icons.local_fire_department;
      case "New Chapter":
        icon = Icons.library_books;
      default:
        icon = Icons.post_add;
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
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
                  child: HotKomikCardWidget(
                    coverImg: komik.coverImg,
                    title: komik.title,
                    chapter: komik.latestChapter,
                    rating: komik.rating,
                    type: komik.type,
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
