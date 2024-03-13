import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/type_flag.dart';
import 'package:mangap/core/constants/color.dart';

class HotKomikCardWidget extends StatelessWidget {
  const HotKomikCardWidget({
    super.key,
    required this.coverImg,
    required this.title,
    required this.chapter,
    required this.rating,
    required this.type,
  });

  final String coverImg;
  final String title;
  final String chapter;
  final String rating;
  final String type;

  @override
  Widget build(BuildContext context) {
    String flag = TypeFlagWidget.getFlag(type);

    return Container(
      width: 240,
      height: 320, // Sesuaikan tinggi dengan kebutuhan Anda
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstant.kThird,
      ),
      child: GestureDetector(
        onTap: () {
          print("tap");
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageWidget(flag),
              const SizedBox(
                height: 12,
              ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: ColorConstant.whiteColor,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              _ratingWidget(chapter, rating),
            ],
          ),
        ),
      ),
    );
  }

  Row _ratingWidget(String chapter, String rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 2,
            top: 1,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ColorConstant.whiteColor,
          ),
          child: Text(
            "Ch $chapter",
            style: GoogleFonts.openSans(
              color: ColorConstant.kThird,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Color(0xFFFFC700),

              size: 20, // Sesuaikan ukuran ikon jika diperlukan
            ),
            const SizedBox(
              width: 2,
            ), // Tambahkan jarak kecil antara ikon dan teks rating
            Text(
              rating,
              style: GoogleFonts.openSans(
                color: ColorConstant.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Stack _imageWidget(String flag) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            key: key,
            imageUrl: coverImg,
            fit: BoxFit.cover,
            width: 240,
            height: 320,
            cacheManager: CacheManager(
              Config(
                'komik',
                stalePeriod: const Duration(minutes: 30),
              ),
            ), // Sesuaikan dengan tinggi kontainer
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  type.toUpperCase(),
                  style: GoogleFonts.openSans(
                    color: ColorConstant.whiteColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 6),
                SvgPicture.asset(
                  flag,
                  width: 18,
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
