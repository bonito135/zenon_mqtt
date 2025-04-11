import 'dart:ui';

Locale defaultLangLocale(Locale fullLocale) {
  final fullLangCode = fullLocale.languageCode;
  return Locale(fullLangCode.substring(0, 2));
}
