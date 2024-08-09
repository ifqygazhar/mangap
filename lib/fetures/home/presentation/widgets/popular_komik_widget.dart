import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/container_custom.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/presentation/pages/detail_page.dart';

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
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return DetailPage(href: href);
          },
        ),
      ),
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
                      key: UniqueKey(),
                      imageUrl: thumbnail,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      cacheManager: CacheManager(
                        Config(
                          'komik',
                          stalePeriod: const Duration(minutes: 10),
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
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            genre,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

  Widget _buildContainerRectangle({
    required Color rectangleColor,
    required Color textColor,
    required String text,
  }) {
    return ContainerCustomWidget(
      containerColor: rectangleColor,
      title: text,
      fontColor: textColor,
    );
  }
}
