import 'package:floor/floor.dart';
import 'package:mangap/fetures/read/data/models/read_model.dart';

class ReadEntity {
  const ReadEntity({
    required this.title,
    required this.prev,
    required this.next,
    required this.panel,
  });

  final String title;
  final String? prev;
  final String? next;

  @TypeConverters([PanelTypeConverter])
  final List<dynamic> panel;
}
