Map<String, String> formatTitle(String title) {
  // Deteksi angka yang muncul setelah kata "chapter" (case-insensitive)
  final chapterMatch = RegExp(
    r'chapter\s*[^\d]*(\d+)', // Menangkap angka setelah "chapter" dan mengabaikan teks non-digit di antara
    caseSensitive: false,
  ).firstMatch(title);
  final chapterNumber = chapterMatch?.group(1) ?? '';

  // Menghapus kata "chapter", teks dalam tanda kurung, dan angka yang mengikutinya dari judul
  String formattedText = title
      .replaceAll(RegExp(r'chapter\s*[^\d]*(\d+)', caseSensitive: false),
          '') // Menghapus "chapter", teks non-digit, dan angka setelahnya
      .replaceAll(RegExp(r'[-/]'), ' ') // Mengganti '/' dan '-' dengan spasi
      .replaceAll(RegExp(r'\s+'),
          ' ') // Mengganti spasi ekstra dengan satu spasi jika ada
      .trim(); // Menghapus spasi di awal dan akhir

  return {
    'text': formattedText,
    'number': chapterNumber,
  };
}
