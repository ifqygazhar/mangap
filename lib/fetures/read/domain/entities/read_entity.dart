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
  final List<dynamic> panel;
}
