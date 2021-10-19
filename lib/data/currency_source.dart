import 'dart:convert';

import 'package:currencies/model/currency.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/services.dart' show rootBundle;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class CurrencySource {
  List<Currency> _currencies = List.empty();
  final Logger _logger;

  CurrencySource(this._logger);

  Future<List<Currency>> getCurrencies() async {
    if (_currencies.isEmpty) {
      _currencies = await getCurrenciesFromAssets();
    }
    return List.from(_currencies);
  }

  Future<List<Currency>> getCurrenciesFromAssets() async {
    _logger.d("Load currencies json from assets");
    String currenciesJson = await _loadCurrenciesJsonFromAssets();
    _logger.d("Parse currencies json");
    return _parseCurrenciesJsonInBackground(currenciesJson);
  }

  Future<String> _loadCurrenciesJsonFromAssets() async {
    String currenciesJsonFilePath = "assets/currencies.json";
    return rootBundle.loadString(currenciesJsonFilePath);
  }

  Future<List<Currency>> _parseCurrenciesJsonInBackground(
      String currenciesJson) {
    return compute(_parseCurrenciesJson, currenciesJson);
  }
}

List<Currency> _parseCurrenciesJson(String currenciesJson) {
  Map<String, dynamic> decodedJson = jsonDecode(currenciesJson);
  return decodedJson.entries
      .map((e) => Currency(name: e.value, code: e.key))
      .toList();
}
