import 'package:currencies/di/injectable.dart';
import 'package:currencies/model/currency.dart';
import 'package:currencies/model/currency_service.dart';
import 'package:currencies/ui/currency_select/currency_select_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

final currencySelectViewModelProvider =
    Provider.autoDispose<CurrencySelectViewModel>((_) => getIt());

@injectable
class CurrencySelectViewModel {
  List<Currency> _originalCurrencies = List.empty();

  final ValueNotifier<CurrencySelectState> _state =
      ValueNotifier(const CurrencySelectState.loading());

  ValueListenable<CurrencySelectState> get state => _state;

  CurrencySelectViewModel({
    required CurrencyService currencyService,
  }) {
    currencyService
        .getCurrencies()
        .then((value) => _originalCurrencies = value)
        .whenComplete(() {
      _state.value = CurrencySelectState.ready(_originalCurrencies);
    });
  }

  void filterCurrencies(String query) {
    if (query.isEmpty) {
      resetFilter();
    } else {
      final lowerCaseCuery = query.toLowerCase();
      final filteredCurrencies = _originalCurrencies
          .where((currency) =>
              currency.name.toLowerCase().contains(lowerCaseCuery) ||
              currency.code.toLowerCase().contains(lowerCaseCuery))
          .toList();
      _state.value = CurrencySelectState.ready(filteredCurrencies);
    }
  }

  void resetFilter() {
    _state.value = CurrencySelectState.ready(_originalCurrencies);
  }
}
