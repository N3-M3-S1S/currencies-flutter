import 'dart:async';

import 'package:currencies/data/app_configuration_storage.dart';
import 'package:currencies/model/currency_service.dart';
import 'package:injectable/injectable.dart';

import '../../../model/currency.dart';

@singleton
@preResolve
class AppConfiguration {
  AppConfiguration._(this._currencyService, this._appConfigurationStorage);

  @factoryMethod
  static Future<AppConfiguration> create(
      {required CurrencyService currencyService,
      required AppConfigurationStorage appConfigurationStorage}) async {
    AppConfiguration appConfiguration =
        AppConfiguration._(currencyService, appConfigurationStorage);
    await appConfiguration._initialize();
    return appConfiguration;
  }

  final CurrencyService _currencyService;
  final AppConfigurationStorage _appConfigurationStorage;
  late Currency _selectedConverterFromCurrency;
  late Currency _selectedConverterToCurrency;
  late Currency _selectedExchangeRatesBaseCurrency;
  late bool _darkModeEnabled;

  Currency get selectedConverterFromCurrency => _selectedConverterFromCurrency;
  Currency get selectedConverterToCurrency => _selectedConverterToCurrency;
  Currency get selectedExchangeRatesBaseCurrency =>
      _selectedExchangeRatesBaseCurrency;
  bool get darkModeEnabled => _darkModeEnabled;

  Future<void> _initialize() async {
    _selectedConverterFromCurrency =
        await _appConfigurationStorage.getSavedConverterFromCurrency() ??
            await _getDefaultConverterFromCurrency();
    _selectedConverterToCurrency =
        await _appConfigurationStorage.getSavedConverterToCurrency() ??
            await _getDefaultConverterToCurrency();
    _selectedExchangeRatesBaseCurrency =
        await _appConfigurationStorage.getSavedExchangeRatesBaseCurrency() ??
            await _getDefaultExchangeRatesBaseCurrency();
    _darkModeEnabled =
        await _appConfigurationStorage.getDarkModeState() ?? false;
  }

  Future<Currency> _getDefaultConverterFromCurrency() =>
      _getCurrencyByCodeOrThrow("usd");

  Future<Currency> _getDefaultConverterToCurrency() =>
      _getCurrencyByCodeOrThrow("rub");

  Future<Currency> _getDefaultExchangeRatesBaseCurrency() =>
      _getCurrencyByCodeOrThrow("eur");

  Future<Currency> _getCurrencyByCodeOrThrow(String currencyCode) async {
    final currency = await _currencyService.getCurrencyByCode(currencyCode);
    if (currency == null) {
      throw ("Cannot find currency with code: $currencyCode");
    }
    return currency;
  }

  Future<void> saveSelectedConverterFromCurrency(Currency currency) =>
      _appConfigurationStorage.saveConverterFromCurrency(currency);

  Future<void> saveSelectedConverterToCurrency(Currency currency) =>
      _appConfigurationStorage.saveConverterToCurrency(currency);

  Future<void> saveSelectedExchangeRatesBaseCurrency(Currency currency) =>
      _appConfigurationStorage.saveExchangeRatesBaseCurrency(currency);

  Future<void> saveDarkModeState(bool darkModeEnabled) =>
      _appConfigurationStorage.saveDarkModeState(darkModeEnabled);
}
