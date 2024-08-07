import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';

class PopularKomikWidget extends StatelessWidget {
  const PopularKomikWidget({
    super.key,
    required this.title,
    required this.href,
    required this.genre,
    required this.year,
    required this.thumbnail,
  });

  final String title;
  final String href;
  final String genre;
  final String year;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tap");
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8, top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorConstant.kThird,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      key: key,
                      imageUrl: thumbnail,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      cacheManager: CacheManager(
                        Config(
                          'komik',
                          stalePeriod: const Duration(minutes: 30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTypeStatusCh(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildTypeStatusCh() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: ColorConstant.whiteColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              _buildContainerRectangle(
                rectangleColor: ColorConstant.whiteColor,
                textColor: ColorConstant.kThird,
                text: year,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildContainerRectangle({
    required Color rectangleColor,
    required Color textColor,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: rectangleColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              color: textColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
