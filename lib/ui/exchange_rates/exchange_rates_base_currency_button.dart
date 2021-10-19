import 'package:currencies/ui/common/currency_dropdown_textfield_button.dart';
import 'package:currencies/ui/currency_select/currency_select_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'exchange_rates_viewmodel.dart';

class ExchangeRatesBaseCurrencyButton extends HookConsumerWidget {
  const ExchangeRatesBaseCurrencyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(exchangeRatesViewModelProvider);
    final baseCurrency = useValueListenable(viewModel.baseCurrency);
    return CurrencyDropdownTextFieldButton(
        title: "Base currency",
        currency: baseCurrency,
        onClick: () {
          showCurrencySelectBottomSheet(context, viewModel.baseCurrencyChanged);
        });
  }
}
