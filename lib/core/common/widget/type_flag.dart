import 'package:mangap/core/constants/flag.dart';

class TypeFlagWidget {
  static String getFlag(String type) {
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
    return flag;
  }
}
