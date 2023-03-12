import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef Translations = AppLocalizations;

class Localization {
  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;
  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      AppLocalizations.localizationsDelegates;
}

abstract class AppTranslations {
  static Translations of(BuildContext context) {
    return AppLocalizations.of(context);
  }
}

String getCurrentLanguageCode(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}
