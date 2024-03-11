import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/core/constants/flag.dart';

class HotKomikCardWidget extends StatelessWidget {
  const HotKomikCardWidget({
    super.key,
    required this.coverImg,
    required this.title,
    required this.chapter,
    required this.rating,
    required this.type,
  });

  final String coverImg;
  final String title;
  final String chapter;
  final String rating;
  final String type;

  @override
  Widget build(BuildContext context) {
    String flag;
    switch (type) {
      case 'Manga':
        flag = FlagConstant.japanFlag; // Bendera Jepang

      case 'Manhwa':
        flag = FlagConstant.koreaFlag; // Bendera Korea

      case 'Manhua':
        flag = FlagConstant.chinaFlag; // Bendera China

      default:
        flag = ''; // Tidak ada bendera untuk jenis komik lainnya
    }

    return Container(
      width: 240,
      height: 320, // Sesuaikan tinggi dengan kebutuhan Anda
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kThird,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageWidget(flag),
            const SizedBox(
              height: 12,
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            _ratingWidget(chapter, rating),
          ],
        ),
      ),
    );
  }

  Row _ratingWidget(String chapter, String rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 2,
            top: 1,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: buttonBlue,
          ),
          child: Text(
            "Ch $chapter",
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Color(0xFFFFC700),

              size: 20, // Sesuaikan ukuran ikon jika diperlukan
            ),
            const SizedBox(
              width: 2,
            ), // Tambahkan jarak kecil antara ikon dan teks rating
            Text(
              rating,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Stack _imageWidget(String flag) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            key: key,
            imageUrl: coverImg,
            fit: BoxFit
                .cover, // Atur agar gambar diisi ke dalam wadah tanpa distorsi
            width: 240, // Sesuaikan dengan lebar kontainer
            height: 320,
            cacheManager: CacheManager(
              Config(
                'komik',
                stalePeriod: const Duration(minutes: 5),
              ),
            ), // Sesuaikan dengan tinggi kontainer
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  type.toUpperCase(),
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 6),
                SvgPicture.asset(
                  flag,
                  width: 18,
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
