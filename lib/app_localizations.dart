import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    log("App Localizations Loading...", name: 'AppLocalizations');
    // Load the language JSON file from the "lang" folder
    final jsonString = await rootBundle.loadString('i18n/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = flatten(json.decode(jsonString) as Map<String, Object>);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    log("App Localizations Loaded", name: 'AppLocalizations');
    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    if (_localizedStrings[key] == null) log('$key not found', name: 'AppLocalizations');
    return _localizedStrings[key] ?? key;
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Flatten object
Map<String, Object> flatten(
  Map<String, Object> target, {
  String delimiter = '_',
  bool safe = false,
  int maxDepth,
}) {
  final result = <String, Object>{};

  void step(
    Map<String, Object> obj, [
    String previousKey,
    int currentDepth = 1,
  ]) {
    obj.forEach((key, value) {
      if (key.startsWith('@')) return;

      final newKey = previousKey != null ? '$previousKey$delimiter$key' : key;

      if (maxDepth != null && currentDepth >= maxDepth) {
        result[newKey] = value;
        return;
      }
      if (value is Map<String, Object>) {
        return step(value, newKey, currentDepth + 1);
      }
      if (value is List && !safe) {
        return step(
          _listToMap(value),
          newKey,
          currentDepth + 1,
        );
      }
      result[newKey] = value;
    });
  }

  step(target);

  return result;
}

Map<String, T> _listToMap<T>(List<T> list) => list.asMap().map((key, value) => MapEntry(key.toString(), value));
