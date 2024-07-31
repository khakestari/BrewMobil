import 'package:flutter/material.dart';

enum LanguageType {
  ENGLISH,
  PERSIAN,
}

const String ENGLISH = "en";
const String PERSIAN = "pr";
const String ASSETS_PATH_LOCALIZATIONS = "assets/translations";
const Locale ENGLISH_LOCAL = Locale("en", "US");
const Locale PERSIAN_LOCAL = Locale("ar", "DZ");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.PERSIAN:
        return PERSIAN;
    }
  }
}
