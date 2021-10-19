import 'package:currencies/ui/common/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'exchange_rates_viewmodel.dart';

class ExchangeRatesError extends ConsumerWidget {
  final String errorMessage;

  const ExchangeRatesError({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(exchangeRatesViewModelProvider);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
          child:
              SingleChildScrollView(child: ErrorText(errorText: errorMessage))),
      const SizedBox(height: 16),
      ElevatedButton(
          onPressed: viewModel.loadExchangeRates, child: const Text("Retry"))
    ]);
  }
}
