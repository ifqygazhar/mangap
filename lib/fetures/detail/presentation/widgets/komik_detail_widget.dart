import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/core/common/widget/container_custom.dart';
import 'package:mangap/core/common/widget/type_flag.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';

class KomikDetailWidget extends StatelessWidget {
  const KomikDetailWidget({
    super.key,
    required this.title,
    required this.author,
    required this.year,
    required this.rate,
    required this.status,
    required this.type,
    required this.thumbnail,
    required this.genres,
  });

  final String title;
  final String author;
  final String year;
  final String rate;
  final String status;
  final String type;
  final String thumbnail;

  final List<GenreEntity> genres;

  @override
  Widget build(BuildContext context) {
    String flag = TypeFlagWidget.getFlag(type);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstant.kThird,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildImageStack(flag, thumbnail, type),
            const SizedBox(
              width: 14,
            ),
            _buildInformationDetail(
              title,
              author,
              year,
              rate,
              status,
              genres,
            ),
          ],
        ),
      ),
    );
  }
}

Stack _buildImageStack(String flag, String thumbnail, String type) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: thumbnail,
          fit: BoxFit.cover,
          width: 128,
          height: 170,
          cacheManager: CacheManager(
            Config(
              'komik',
              stalePeriod: const Duration(minutes: 10),
            ),
          ),
        ),
      ),
      Positioned(
        top: 4,
        left: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                type,
                style: GoogleFonts.openSans(
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 8,
                ),
              ),
              const SizedBox(width: 6),
              SvgPicture.asset(
                flag,
                width: 12,
                height: 12,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Expanded _buildInformationDetail(
  String title,
  String author,
  String year,
  String rate,
  String status,
  List<GenreEntity> genres,
) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: ColorConstant.whiteColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "$author, Released $year",
          style: GoogleFonts.openSans(
            color: ColorConstant.lightText,
            fontSize: 12,
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
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 6),
            _buildStarRating(double.parse(rate)),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Row(
          children: [
            ContainerCustomWidget(
              containerColor: Colors.amber,
              title: "Ongoing",
              fontColor: ColorConstant.kThird,
              fontSize: 10,
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

Widget _buildStarRating(double rating) {
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
