class PageIntroInfo {
  final String pageTitle;
  final String introText;
  final String? supplementaryText;

  const PageIntroInfo({
    required this.pageTitle,
    required this.introText,
    this.supplementaryText,
  });
}
