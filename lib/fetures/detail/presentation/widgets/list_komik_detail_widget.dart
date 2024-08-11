import 'package:flutter/material.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:mangap/fetures/detail/presentation/widgets/komik_detail_widget.dart';

class ListKomikDetailWidget extends StatelessWidget {
  const ListKomikDetailWidget({
    super.key,
    required this.details,
    required this.genres,
  });

  final KomikDetailEntity details;
  final List<GenreEntity> genres;

  @override
  Widget build(BuildContext context) {
    return KomikDetailWidget(
      title: details.title,
      author: details.author == "" ? "Author Not Found" : details.author,
      year: details.released,
      rate: details.rating,
      status: details.status,
      type: details.type,
      thumbnail: details.thumbnail,
    );
  }
}
