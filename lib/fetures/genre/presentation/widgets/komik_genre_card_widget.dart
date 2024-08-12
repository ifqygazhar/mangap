import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/komik_card.dart';
import 'package:mangap/fetures/detail/presentation/pages/detail_page.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';

class KomikGenreCardWidget extends StatelessWidget {
  const KomikGenreCardWidget({
    super.key,
    required this.title,
    required this.chapter,
    required this.href,
    required this.rate,
    required this.type,
    required this.thumbnail,
  });

  final String title;
  final String chapter;
  final String href;
  final String rate;
  final String type;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<NavigationBloc>().add(HideBottomBarEvent());
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              href: href,
            ),
          ),
        );
        context.read<NavigationBloc>().add(ShowBottomBarEvent());
      },
      child: KomikCardWidget(
        title: title,
        chapter: chapter,
        href: href,
        rate: rate,
        type: type,
        thumbnail: thumbnail,
        onTap: () {},
      ),
    );
  }
}
