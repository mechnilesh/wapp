import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get weather => 'Weather';

  @override
  String get weather_application => 'Weather Application';

  @override
  String get weather_app => 'Weather App';

  @override
  String get current => 'Current';

  @override
  String get feels_like => 'Feels like ';

  @override
  String get language => 'english';

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get light_mode => 'Light Mode';
}
