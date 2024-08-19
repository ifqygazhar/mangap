import 'package:flutter/material.dart';
import 'package:mangap/core/common/widget/rating.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:mangap/fetures/detail/presentation/widgets/komik_detail_widget.dart';

class ListKomikDetailWidget extends StatelessWidget {
  const ListKomikDetailWidget({
    super.key,
    required this.details,
    required this.href,
  });

  final KomikDetailEntity details;

  final String href;

  @override
  Widget build(BuildContext context) {
    return KomikDetailWidget(
      href: href,
      title: details.title,
      author: details.author == "" ? "Author Not Found" : details.author,
      year: details.released,
      rate: fixedRating(details.rating),
      status: details.status,
      type: details.type,
      thumbnail: details.thumbnail,
    );
  }
}
