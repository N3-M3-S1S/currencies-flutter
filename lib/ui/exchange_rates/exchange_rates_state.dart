import 'package:currencies/model/currency.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_rates_state.freezed.dart';

@freezed
class ExchangeRatesState with _$ExchangeRatesState {
  const factory ExchangeRatesState.loading() = _ExchangeRatesStateLoading;
  const factory ExchangeRatesState.ready(Map<Currency, double> exchangeRates) =
      _ExchangeRatesStateReady;
  const factory ExchangeRatesState.error(String errorMessage) =
      _ExchangeRatesStateError;
}
