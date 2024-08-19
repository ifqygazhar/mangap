import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/core/common/widget/container_custom.dart';
import 'package:mangap/core/common/widget/image_stack.dart';
import 'package:mangap/core/common/widget/rating.dart';
import 'package:mangap/core/common/widget/type_flag.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/domain/entities/komik_detail_entity.dart';
import 'package:mangap/fetures/detail/presentation/bloc/detail_bloc.dart';

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
    required this.href,
  });

  final String href;
  final String title;
  final String author;
  final String year;
  final String rate;
  final String status;
  final String type;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    String flag = TypeFlagWidget.getFlag(type);
    final isBookmarked =
        context.select((DetailBloc bloc) => bloc.state.isBookmarked);
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
            ImageStackWidget(flag: flag, thumbnail: thumbnail, type: type),
            const SizedBox(
              width: 14,
            ),
            _buildInformationDetail(
                context, title, author, year, rate, status, isBookmarked),
          ],
        ),
      ),
    );
  }

  Expanded _buildInformationDetail(
    BuildContext context,
    String title,
    String author,
    String year,
    String rate,
    String status,
    bool isBookmark,
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
              RatingWidget(rating: double.parse(rate)),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              ContainerCustomWidget(
                containerColor: Colors.amber,
                title: status,
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
              isIcon: true,
              icon: Icon(
                isBookmark ? Icons.bookmark_remove : Icons.bookmark_add,
                color: isBookmark
                    ? ColorConstant.whiteColor
                    : ColorConstant.kThird,
              ),
              onTap: () {
                if (isBookmark) {
                  context.read<DetailBloc>().add(
                        DetailRemoveBookmark(
                          KomikDetailEntity(
                            href: href,
                            title: title,
                            author: author,
                            released: year,
                            rating: rate,
                            status: status,
                            type: type,
                            thumbnail: thumbnail,
                            altTitle: '',
                            updatedOn: '',
                            description: '',
                          ),
                        ),
                      );
                } else {
                  context.read<DetailBloc>().add(
                        DetailAddBookmark(
                          KomikDetailEntity(
                            href: href,
                            title: title,
                            author: author,
                            released: year,
                            rating: rate,
                            status: status,
                            type: type,
                            thumbnail: thumbnail,
                            altTitle: '',
                            updatedOn: '',
                            description: '',
                          ),
                        ),
                      );
                }
              },
              color: isBookmark
                  ? ColorConstant.kPrimary
                  : ColorConstant.whiteColor,
              text: isBookmark ? "Unbookmark" : "Bookmark",
              circular: 4,
              foregroundColor:
                  isBookmark ? ColorConstant.whiteColor : ColorConstant.kThird,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
