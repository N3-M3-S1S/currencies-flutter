import 'package:currencies/ui/exchange_rates/exchange_rates_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'exchange_rates_error.dart';
import 'exchange_rates_list.dart';
import 'exchange_rates_viewmodel.dart';

class ExchangeRatesStateDisplay extends HookConsumerWidget {
  const ExchangeRatesStateDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(exchangeRatesViewModelProvider);
    final exchangeRatesState = useValueListenable(viewModel.exchangeRatesState);
    final widgetForState = _buildWidgetForState(exchangeRatesState);
    return Center(child: widgetForState);
  }

  Widget _buildWidgetForState(ExchangeRatesState state) => state.when(
      loading: () => const CircularProgressIndicator(),
      ready: (exchangeRates) => ExchangeRatesList(exchangeRates: exchangeRates),
      error: (errorMessage) => Padding(
          padding: const EdgeInsets.all(16),
          child: ExchangeRatesError(errorMessage: errorMessage)));
}
