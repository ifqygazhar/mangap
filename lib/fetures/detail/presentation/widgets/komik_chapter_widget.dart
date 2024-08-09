import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';

class KomikChapterWidget extends StatelessWidget {
  const KomikChapterWidget({super.key, required this.chapters});

  final List<ChapterEntity> chapters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Chapters",
          style: GoogleFonts.openSans(
            color: ColorConstant.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 400,
          child: ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 3, top: 8),
                  decoration: BoxDecoration(
                    color: ColorConstant.kThird,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chapter.title,
                          style: GoogleFonts.openSans(
                            color: ColorConstant.whiteColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          chapter.date,
                          style: GoogleFonts.openSans(
                            color: ColorConstant.whiteColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
