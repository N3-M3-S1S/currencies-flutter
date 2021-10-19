import 'package:currencies/data/currency_exchange_rates_source.dart';
import 'package:currencies/data/currency_source.dart';
import 'package:currencies/model/currency.dart';
import 'package:injectable/injectable.dart';

@singleton
class CurrencyService {
  final CurrencySource _currencySource;
  final CurrencyExchangeRatesSource _currencyExchangeRatesSource;

  CurrencyService(this._currencySource, this._currencyExchangeRatesSource);

  Future<List<Currency>> getCurrencies() => _currencySource.getCurrencies();

  Future<double> convertCurrencies(
      Currency fromCurrency, Currency toCurrency, double amount) async {
    double exchangeRate = await _currencyExchangeRatesSource
        .getCurrencyExchangeRate(fromCurrency, toCurrency);
    return amount * exchangeRate;
  }

  Future<double> getExchangeRate(Currency fromCurrency, Currency toCurrency) =>
      convertCurrencies(fromCurrency, toCurrency, 1);

  Future<Map<Currency, double>> getCurrencyExchangeRates(
          Currency baseCurrency) =>
      _currencyExchangeRatesSource.getCurrencyExchangeRates(baseCurrency);

  Future<Currency?> getCurrencyByCode(String currencyCode) async {
    var currencies = await getCurrencies();
    Currency? result =
        currencies.firstWhere((element) => element.code == currencyCode);
    return result;
  }
}
