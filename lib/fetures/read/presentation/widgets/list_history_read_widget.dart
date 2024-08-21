import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/container_custom.dart';
import 'package:mangap/core/constants/color.dart';

class ListHistoryReadWidget extends StatelessWidget {
  final String title;

  const ListHistoryReadWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.openSans(
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
            const ContainerCustomWidget(
              containerColor: Colors.amber,
              title: 'chapter',
              fontColor: ColorConstant.kThird,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
