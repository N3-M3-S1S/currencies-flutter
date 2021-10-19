import 'package:currencies/model/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_select_state.freezed.dart';

@freezed
class CurrencySelectState with _$CurrencySelectState {
  const factory CurrencySelectState.loading() = _CurrencySelectStateLoading;
  const factory CurrencySelectState.ready(List<Currency> currencies) =
      _CurrencySelectStateReady;
}
