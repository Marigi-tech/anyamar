String capitalizeFirstLetter(String text) {
  final trimmedText = text.trim();

  if (trimmedText.isEmpty) return trimmedText;

  return '${trimmedText[0].toUpperCase()}${trimmedText.substring(1)}';
}
