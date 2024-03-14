enum LanguageType {
  ENGLISH,
  PERSIAN,
  ARABIC,
}

const String ENGLISH = "en";
const String PERSIAN = "pr";
const String ARABIC = "ar";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.PERSIAN:
        return PERSIAN;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}
