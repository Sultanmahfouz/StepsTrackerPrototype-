import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _localizedStrings;

  // load the localized value for "locale" and initlize it to "_localizesStrings"
  Future<void> load() async {
    //load the language JSON form the "lang" folder
    String jsonString = await rootBundle
        .loadString("assets/languages/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    // load and convert <String,dynamic> to <String,String>
    _localizedStrings = jsonMap.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );
  }

  String getTitle(String context) {
    return _localizedStrings[context];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // include all the supported languages
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // here where load get called
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
