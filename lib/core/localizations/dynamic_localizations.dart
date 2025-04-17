import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

class DynamicLocalization {
  static String? arbContent;
  static Map<String, dynamic>? localizedMap = {};

  static init(Locale? locale) async {
    final fallbackLocale = locale?.languageCode.substring(0, 2);
    final filePath = 'lib/l10n/app_${locale?.languageCode}.arb';
    final fallbackFilePath = 'lib/l10n/app_$fallbackLocale.arb';
    final defaultFilePath = 'lib/l10n/app_en.arb';

    try {
      arbContent = await rootBundle.loadString(filePath);
      localizedMap = jsonDecode(arbContent!) as Map<String, dynamic>;
    } catch (e) {
      try {
        arbContent = await rootBundle.loadString(fallbackFilePath);
        localizedMap = jsonDecode(arbContent!) as Map<String, dynamic>;
      } catch (e) {
        arbContent = await rootBundle.loadString(defaultFilePath);
        localizedMap = jsonDecode(arbContent!) as Map<String, dynamic>;
      }
    }
  }

  static String translate(String key) {
    return localizedMap?[key] as String? ?? key;
  }
}
