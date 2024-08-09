import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/container_custom.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';

class KomikGenreWidget extends StatelessWidget {
  const KomikGenreWidget({super.key, required this.genres});

  final List<GenreEntity> genres;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstant.kThird,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Genre',
              style: GoogleFonts.openSans(
                color: ColorConstant.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return Row(
                    children: [
                      ContainerCustomWidget(
                        containerColor: ColorConstant.whiteColor,
                        title: genre.title,
                        fontColor: ColorConstant.kThird,
                        marginRight: 10,
                        padding: 4,
                        fontSize: 10,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
