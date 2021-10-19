import 'package:currencies/di/injectable.dart';
import 'package:currencies/model/currency.dart';
import 'package:currencies/model/currency_service.dart';
import 'package:currencies/ui/app/configuration/app_configuration.dart';
import 'package:currencies/ui/converter/converter_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

final converterScreenViewModelProvider =
    Provider<ConverterScreenViewModel>((_) => getIt());

@injectable
class ConverterScreenViewModel {
  ConverterScreenViewModel(this._currencyService, this._appConfiguration) {
    _fromCurrency =
        ValueNotifier(_appConfiguration.selectedConverterFromCurrency);
    _toCurrency = ValueNotifier(_appConfiguration.selectedConverterToCurrency);
  }

  final CurrencyService _currencyService;
  final AppConfiguration _appConfiguration;
  late final ValueNotifier<Currency> _fromCurrency;
  late final ValueNotifier<Currency> _toCurrency;
  final ValueNotifier<bool> _convertAvailable = ValueNotifier(false);
  final ValueNotifier<bool> _currencyInputValid = ValueNotifier(true);
  final ValueNotifier<ConverterState> _converterState =
      ValueNotifier(const ConverterState.empty());
  final RegExp _validCurrencyAmountInputRegExp = RegExp(r'^(\d+(?:\.\d*)?)?$');
  String _currencyAmountInput = "";
  double _currencyAmount = 0;

  ValueListenable<Currency> get fromCurrency => _fromCurrency;
  ValueListenable<Currency> get toCurrency => _toCurrency;
  ValueListenable<bool> get convertAvailable => _convertAvailable;
  ValueListenable<bool> get currencyInputValid => _currencyInputValid;
  ValueListenable<ConverterState> get converterState => _converterState;
  String get currencyAmountInput => _currencyAmountInput;

  void fromCurrencyChanged(Currency currency) {
    _fromCurrency.value = currency;
    _appConfiguration.saveSelectedConverterFromCurrency(currency);
  }

  void toCurrencyChanged(Currency currency) {
    _toCurrency.value = currency;
    _appConfiguration.saveSelectedConverterToCurrency(currency);
  }

  void currencyAmountInputChanged(String currencyAmountInput) {
    _currencyInputValid.value =
        _validCurrencyAmountInputRegExp.hasMatch(currencyAmountInput);
    if (_currencyInputValid.value) {
      final currencyAmount = double.tryParse(currencyAmountInput) ?? 0;
      _currencyAmount = currencyAmount;
      _convertAvailable.value = currencyAmount > 0;
    } else {
      _convertAvailable.value = false;
    }
    _currencyAmountInput = currencyAmountInput;
  }

  void currencyAmountChanged(double amount) {
    _convertAvailable.value = amount > 0;
    _currencyAmount = amount;
  }

  void swapCurrencies() {
    final fromCurrency = _fromCurrency.value;
    fromCurrencyChanged(_toCurrency.value);
    toCurrencyChanged(fromCurrency);
  }

  void convert() async {
    _converterState.value = const ConverterState.loading();
    final fromCurrencyValue = fromCurrency.value;
    final toCurrencyValue = toCurrency.value;
    try {
      final conversionResult = await _currencyService.convertCurrencies(
          fromCurrencyValue, toCurrencyValue, _currencyAmount);
      final exchangeRate = await _currencyService.getExchangeRate(
          fromCurrencyValue, toCurrencyValue);
      _converterState.value = ConverterState.result(fromCurrencyValue,
          _currencyAmount, toCurrencyValue, conversionResult, exchangeRate);
    } catch (e) {
      _converterState.value = ConverterState.error(e.toString());
    }
  }
}
