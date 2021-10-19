import 'package:currencies/model/currency.dart';
import 'package:currencies/ui/common/currency_dropdown_textfield_button.dart';
import 'package:currencies/ui/currency_select/currency_select_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'converter_viewmodel.dart';

class CurrencyFromSelectButton extends _ConverterCurrencySelectButton {
  const CurrencyFromSelectButton({Key? key}) : super(key: key);

  @override
  ValueListenable<Currency> _getSelectedCurrency(
          ConverterScreenViewModel viewModel) =>
      viewModel.fromCurrency;

  @override
  void _onCurrencySelected(
          ConverterScreenViewModel viewModel, Currency selectedCurrency) =>
      viewModel.fromCurrencyChanged(selectedCurrency);

  @override
  String get _title => "From";
}

class CurrencyToSelectButton extends _ConverterCurrencySelectButton {
  const CurrencyToSelectButton({Key? key}) : super(key: key);

  @override
  ValueListenable<Currency> _getSelectedCurrency(
          ConverterScreenViewModel viewModel) =>
      viewModel.toCurrency;

  @override
  void _onCurrencySelected(
          ConverterScreenViewModel viewModel, Currency selectedCurrency) =>
      viewModel.toCurrencyChanged(selectedCurrency);

  @override
  String get _title => "To";
}

abstract class _ConverterCurrencySelectButton extends HookConsumerWidget {
  const _ConverterCurrencySelectButton({Key? key}) : super(key: key);

  String get _title;
  ValueListenable<Currency> _getSelectedCurrency(
      ConverterScreenViewModel viewModel);
  void _onCurrencySelected(
      ConverterScreenViewModel viewModel, Currency selectedCurrency);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(converterScreenViewModelProvider);
    final selectedCurrency =
        useValueListenable(_getSelectedCurrency(viewModel));
    return Expanded(
        child: CurrencyDropdownTextFieldButton(
            title: _title,
            currency: selectedCurrency,
            onClick: () {
              showCurrencySelectBottomSheet(context, (currency) {
                _onCurrencySelected(viewModel, currency);
              });
            }));
  }
}
