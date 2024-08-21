import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mangap/core/constants/color.dart';

class KomikImageChapterWidget extends StatelessWidget {
  const KomikImageChapterWidget({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: ColorConstant.whiteColor,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.image,
          size: 78,
          color: ColorConstant.whiteColor,
        ),
        key: UniqueKey(),
        imageUrl: image,
        fit: BoxFit.cover,
        cacheManager: CacheManager(
          Config(
            'komik',
            stalePeriod: const Duration(minutes: 10),
          ),
        ),
      ),
    );
  }
}
