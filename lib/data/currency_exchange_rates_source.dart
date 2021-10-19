import 'package:currencies/data/currency_source.dart';
import 'package:currencies/model/currency.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class CurrencyExchangeRatesSource {
  final CurrencySource _currencySource;
  final Dio _httpClient;
  final Logger _logger;
  final String _baseApiUrl =
      "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies";

  CurrencyExchangeRatesSource(
      this._httpClient, this._currencySource, this._logger);

  Future<double> getCurrencyExchangeRate(
      Currency fromCurrency, Currency toCurrency) async {
    String requestUrl =
        _createCurrencyExchangeRateRequestUrl(fromCurrency, toCurrency);
    _logger.d(
        "Query api for exchange rate, from currency: $fromCurrency, to currency: $toCurrency");
    Response response = await _queryApi(requestUrl);
    _logger.d("Parse exchange rate api response");
    return _parseCurrencyExchangeRateResponse(response, toCurrency);
  }

  String _createCurrencyExchangeRateRequestUrl(
          Currency fromCurrency, Currency toCurrency) =>
      "$_baseApiUrl/${fromCurrency.code}/${toCurrency.code}.json";

  double _parseCurrencyExchangeRateResponse(
          Response response, Currency toCurrency) =>
      response.data[toCurrency.code].toDouble(); //can be an integer or a double

  Future<Map<Currency, double>> getCurrencyExchangeRates(
      Currency baseCurrency) async {
    String requestUrl = _createCurrencyExchangeRatesRequestUrl(baseCurrency);
    _logger.d("Query api for exchange rates, base currency: $baseCurrency");
    Response response = await _queryApi(requestUrl);
    _logger.d("Parse exchange rates api response");
    return _parseCurrencyExchangeRatesResponse(response, baseCurrency);
  }

  String _createCurrencyExchangeRatesRequestUrl(Currency baseCurrency) =>
      "$_baseApiUrl/${baseCurrency.code}.json";

  Future<Map<Currency, double>> _parseCurrencyExchangeRatesResponse(
      Response response, Currency baseCurrency) async {
    Map<String, dynamic> currencyCodeToExchangeRate =
        response.data[baseCurrency.code];

    List<Currency> currencies = await _currencySource.getCurrencies();
    //base currency's exchange rate is always 1, no need to add it to the result
    currencies.remove(baseCurrency);

    Map<Currency, double> result = {};
    for (var currency in currencies) {
      //can be an integer or a double, null if there is no exchange rate for the currency
      num? exchangeRateForCurrency = currencyCodeToExchangeRate[currency.code];
      if (exchangeRateForCurrency == null) {
        _logger.d("No exchange rate for currency $currency");
      } else {
        result[currency] = exchangeRateForCurrency.toDouble();
      }
    }
    return result;
  }

  Future<Response> _queryApi(String requestUrl) => _httpClient.get(requestUrl);
}
