import 'package:currencies/model/currency.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppConfigurationStorage {
  final String _converterFromCurrencyKey = "converter_currency_from";
  final String _converterToCurrencyKey = "converter_currency_to";
  final String _exchangeRatesBaseCurrencyKey = "exchange_rates_base_currency";
  final String _darkModeStateKey = "dark_mode";
  final SharedPreferences _sharedPreferences;

  AppConfigurationStorage(this._sharedPreferences);

  Future<void> saveConverterFromCurrency(Currency currency) =>
      _putCurrencyToSharedPreferences(_converterFromCurrencyKey, currency);

  Future<void> saveConverterToCurrency(Currency currency) =>
      _putCurrencyToSharedPreferences(_converterToCurrencyKey, currency);

  Future<void> saveExchangeRatesBaseCurrency(Currency currency) =>
      _putCurrencyToSharedPreferences(_exchangeRatesBaseCurrencyKey, currency);

  Future<void> saveDarkModeState(bool darkModeEnabled) =>
      _sharedPreferences.setBool(_darkModeStateKey, darkModeEnabled);

  Future<void> _putCurrencyToSharedPreferences(
      String key, Currency currency) async {
    final currencyFieldsList = [currency.name, currency.code];
    _sharedPreferences.setStringList(key, currencyFieldsList);
  }

  Future<Currency?> getSavedConverterFromCurrency() => Future.value(
      _getCurrencyFromSharedPreferences(_converterFromCurrencyKey));

  Future<Currency?> getSavedConverterToCurrency() =>
      Future.value(_getCurrencyFromSharedPreferences(_converterToCurrencyKey));

  Future<Currency?> getSavedExchangeRatesBaseCurrency() => Future.value(
      _getCurrencyFromSharedPreferences(_exchangeRatesBaseCurrencyKey));

  Future<bool?> getDarkModeState() =>
      Future.value(_sharedPreferences.getBool(_darkModeStateKey));

  Currency? _getCurrencyFromSharedPreferences(String key) {
    final currencyFieldsList = _sharedPreferences.getStringList(key);
    if (currencyFieldsList == null) {
      return null;
    }
    final currencyName = currencyFieldsList[0];
    final currencyCode = currencyFieldsList[1];
    return Currency(name: currencyName, code: currencyCode);
  }
}
