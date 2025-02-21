import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:werewolves_of_thiercelieux/main.dart';

class Translator {
  static final String _translationName = 'fr_fr';

  static final Translator _instance = Translator._internal();
  Map<String, dynamic>? translations;

  factory Translator() {
    _instance._loadTranslations(_translationName);
    return _instance;
  }

  Translator._internal();

  Future<void> _loadTranslations(String translationName) async {
    if (translations == null || WerewolvesApp.isDebug) {
      String content = await rootBundle.loadString("assets/lang/$translationName.json");
      translations = jsonDecode(content);
    }
  }

  String translate(String key) {
    return translations?[key] ?? 'Translation[$key]';
  }
}
