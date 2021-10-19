import 'package:currencies/model/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "converter_state.freezed.dart";

@freezed
class ConverterState with _$ConverterState {
  const factory ConverterState.empty() = _ConverterStateEmpty;
  const factory ConverterState.loading() = _ConverterStateLoading;
  const factory ConverterState.result(
      Currency fromCurrency,
      double fromCurrencyAmount,
      Currency toCurrency,
      double toCurrencyConversionResult,
      double exchangeRate) = _ConverterStateResult;
  const factory ConverterState.error(String errorMessage) =
      _ConverterStateError;
}
