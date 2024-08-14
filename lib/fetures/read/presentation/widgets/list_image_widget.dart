import 'package:flutter/widgets.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/presentation/widgets/komik_image_widget.dart';

class ListImageWidget extends StatelessWidget {
  final List<ReadEntity> read; // List of ReadEntity

  const ListImageWidget({super.key, required this.read});

  @override
  Widget build(BuildContext context) {
    // Menggabungkan semua panel dari setiap ReadEntity menjadi satu daftar gambar
    final List<String> allPanels =
        read.expand((readEntity) => readEntity.panel.cast<String>()).toList();

    return Column(
      children: allPanels.map((imageUrl) {
        return KomikImageChapterWidget(image: imageUrl);
      }).toList(),
    );
  }
}
