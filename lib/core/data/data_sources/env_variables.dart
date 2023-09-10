import 'package:injectable/injectable.dart';

@LazySingleton(as: AppEnvVariables)
class CurrencyConverterEnvVariables implements AppEnvVariables {

  @override
  String get baseUrl => "https://api.freecurrencyapi.com/v1/";

  @override
  String get flagsBaseUrl => "https://flagcdn.com/";

  @override
  String get defaultHistoricalDataBaseCurrency => "USD";
}

abstract class AppEnvVariables {
  String get baseUrl;

  String get flagsBaseUrl;

  String get defaultHistoricalDataBaseCurrency;
}
