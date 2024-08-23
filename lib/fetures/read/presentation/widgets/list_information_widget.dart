import 'package:flutter/widgets.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/presentation/widgets/information_read_widget.dart';

class ListInformationWidget extends StatelessWidget {
  const ListInformationWidget(
      {super.key, required this.read, required this.route});

  final List<ReadEntity> read;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: read.map((komik) {
        return InformationReadWidget(
          title: komik.title,
          prevHref: komik.prev,
          nextHref: komik.next,
          route: route,
        );
      }).toList(),
    );
  }
}
