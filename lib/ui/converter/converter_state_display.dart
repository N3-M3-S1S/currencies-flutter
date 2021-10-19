import 'package:currencies/ui/common/error_text.dart';
import 'package:currencies/ui/converter/converter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'converter_empty.dart';
import 'converter_result.dart';
import 'converter_viewmodel.dart';

class ConverterStateDisplay extends HookConsumerWidget {
  const ConverterStateDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(converterScreenViewModelProvider);
    final converterState = useValueListenable(viewModel.converterState);
    final widgetForState = _buildWidgetForState(converterState);
    return Center(child: widgetForState);
  }

  Widget _buildWidgetForState(ConverterState state) => state.when(
      loading: () => const CircularProgressIndicator(),
      empty: () => const ConverterEmpty(),
      result: (fromCurrency, fromCurrencyAmount, toCurrency,
              toCurrencyConversionResult, exchangeRate) =>
          ConverterResult(
            fromCurrency: fromCurrency,
            fromCurrencyAmount: fromCurrencyAmount,
            toCurrency: toCurrency,
            toCurrencyConversionResult: toCurrencyConversionResult,
            exchangeRate: exchangeRate,
          ),
      error: (errorMessage) => ErrorText(errorText: errorMessage));
}
