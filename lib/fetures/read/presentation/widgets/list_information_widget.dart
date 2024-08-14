import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/presentation/widgets/information_read_widget.dart';

class ListInformationWidget extends StatelessWidget {
  const ListInformationWidget({super.key, required this.read});

  final List<ReadEntity> read;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: read.map((komik) {
        log(read.toString());
        return InformationReadWidget(
          title: komik.title,
          prevHref: komik.prev,
          nextHref: komik.next,
        );
      }).toList(),
    );
  }
}
