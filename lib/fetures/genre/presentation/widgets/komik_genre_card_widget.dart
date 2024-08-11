import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/core/common/widget/container_custom.dart';
import 'package:mangap/core/common/widget/image_stack.dart';
import 'package:mangap/core/common/widget/rating.dart';
import 'package:mangap/core/common/widget/type_flag.dart';
import 'package:mangap/core/constants/color.dart';
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
    String flag = TypeFlagWidget.getFlag(type);
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
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: ColorConstant.kThird,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ImageStackWidget(flag: flag, thumbnail: thumbnail, type: type),
              const SizedBox(
                width: 14,
              ),
              _buildInformationDetail(
                title,
                chapter,
                rate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Expanded _buildInformationDetail(
  String title,
  String chapter,
  String rate,
) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: ColorConstant.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              rate,
              style: GoogleFonts.openSans(
                color: ColorConstant.whiteColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 6),
            RatingWidget(rating: double.parse(rate)),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            ContainerCustomWidget(
              containerColor: Colors.amber,
              title: chapter,
              fontColor: ColorConstant.kThird,
              fontSize: 12,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.infinity,
          height: 34,
          child: ButtonWidget(
            onTap: () {},
            color: ColorConstant.whiteColor,
            text: "Bookmark",
            circular: 4,
            foregroundColor: ColorConstant.kThird,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
