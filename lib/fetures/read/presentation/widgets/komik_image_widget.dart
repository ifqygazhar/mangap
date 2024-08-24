import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/read/presentation/bloc/read_bloc.dart';

class KomikImageChapterWidget extends StatelessWidget {
  final String image;

  const KomikImageChapterWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final bool isFullscreen =
        context.select((ReadBloc bloc) => bloc.state.isFullscreen);

    return Padding(
      padding: isFullscreen
          ? EdgeInsets.zero
          : const EdgeInsets.only(left: 8.0, right: 8.0),
      child: InteractiveViewer(
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
      ),
    );
  }
}
