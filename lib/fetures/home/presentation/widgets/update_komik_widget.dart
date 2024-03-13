import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/type_color.dart';
import 'package:mangap/core/constants/color.dart';

class UpdateKomikWidget extends StatelessWidget {
  const UpdateKomikWidget({
    super.key,
    required this.coverImg,
    required this.title,
    required this.chapter,
    required this.rating,
    required this.type,
    required this.completed,
  });

  final String coverImg;
  final String title;
  final String chapter;
  final String rating;
  final String type;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final rectangleColor = TypeColor.getColorType(type);
    final textColor = TypeColor.getTextColorType(type);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, top: 8),
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
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      key: key,
                      imageUrl: coverImg,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      cacheManager: CacheManager(
                        Config(
                          'komik',
                          stalePeriod: const Duration(minutes: 30),
                        ),
                      ), // Sesuaikan dengan tinggi kontainer
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTypeStatusCh(rectangleColor, textColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildTypeStatusCh(Color rectangleColor, Color textColor) {
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
                rectangleColor: rectangleColor,
                textColor: textColor,
                text: type,
              ),
              const SizedBox(
                width: 8,
              ),
              _buildContainerRectangle(
                rectangleColor:
                    completed == false ? ColorConstant.whiteColor : Colors.grey,
                textColor: ColorConstant.kThird,
                text: completed == false ? "Ongoing" : "Completed",
              ),
              const Spacer(),
              _buildContainerRectangle(
                rectangleColor: ColorConstant.whiteColor,
                textColor: ColorConstant.kThird,
                text: "Ch $chapter",
              ),
              const Spacer(),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                rating,
                style: GoogleFonts.openSans(
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              )
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
      width: 64,
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
