import 'package:currencies/di/injectable.dart';
import 'package:currencies/model/currency.dart';
import 'package:currencies/model/currency_service.dart';
import 'package:currencies/ui/app/configuration/app_configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import 'exchange_rates_state.dart';

final exchangeRatesViewModelProvider =
    Provider<ExchangeRatesViewModel>((_) => getIt());

@injectable
class ExchangeRatesViewModel {
  ExchangeRatesViewModel(
      {required CurrencyService currencyService,
      required AppConfiguration appConfiguration}) {
    _currencyService = currencyService;
    _appConfiguration = appConfiguration;
    _baseCurrency =
        ValueNotifier(appConfiguration.selectedExchangeRatesBaseCurrency);
    loadExchangeRates();
  }

  late final CurrencyService _currencyService;
  late final ValueNotifier<Currency> _baseCurrency;
  late final AppConfiguration _appConfiguration;
  ValueListenable<Currency> get baseCurrency => _baseCurrency;
  final ValueNotifier<ExchangeRatesState> _exchangeRatesState =
      ValueNotifier(const ExchangeRatesState.loading());
  ValueListenable<ExchangeRatesState> get exchangeRatesState =>
      _exchangeRatesState;

  void baseCurrencyChanged(Currency currency) {
    _baseCurrency.value = currency;
    _appConfiguration.saveSelectedExchangeRatesBaseCurrency(currency);
    loadExchangeRates();
  }

  void loadExchangeRates() async {
    _exchangeRatesState.value = const ExchangeRatesState.loading();
    try {
      final exchangeRates =
          await _currencyService.getCurrencyExchangeRates(_baseCurrency.value);
      _exchangeRatesState.value = ExchangeRatesState.ready(exchangeRates);
    } catch (error) {
      _exchangeRatesState.value = ExchangeRatesState.error(error.toString());
    }
  }
}
