import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';

class ImageStackWidget extends StatelessWidget {
  const ImageStackWidget({
    super.key,
    required this.thumbnail,
    required this.type,
    required this.flag,
  });

  final String thumbnail, type, flag;

  @override
  Stack build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            errorWidget: (context, url, error) => const Icon(
              Icons.image,
              size: 78,
              color: ColorConstant.whiteColor,
            ),
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
}
