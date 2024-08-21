Map<String, String> formatTitle(String title) {
  // Menyimpan angka yang ditemukan
  final numberMatch = RegExp(r'\d+').firstMatch(title);
  final number = numberMatch?.group(0) ?? '';

  // Menghapus karakter '/', '-', kata 'chapter', dan angka dari string
  final formattedText = title
      .replaceAll(RegExp(r'[-/]'), ' ') // Mengganti '/' dan '-' dengan spasi
      .replaceAll(RegExp(r'\d+'), '') // Menghapus angka
      .replaceAll(RegExp(r'\bchapter\b', caseSensitive: false),
          '') // Menghapus kata 'chapter' (tidak case-sensitive)
      .replaceAll(RegExp(r'\s+'),
          ' ') // Mengganti spasi ekstra dengan satu spasi jika ada
      .trim(); // Menghapus spasi di awal dan akhir

  return {
    'text': formattedText,
    'number': number,
  };
}
