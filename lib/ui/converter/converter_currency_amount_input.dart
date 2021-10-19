import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'converter_viewmodel.dart';

class CurrencyAmountInput extends HookConsumerWidget {
  const CurrencyAmountInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(converterScreenViewModelProvider);
    final currencyInputValid = useValueListenable(viewModel.currencyInputValid);

    final inputDecoration = InputDecoration(
        labelText: "Amount",
        border: const OutlineInputBorder(),
        /*Create space for a potential error message by displaying empty hint text (the error message replaces the hint's text). 
            This will prevent the TextFormField from changing its height if the error message is shown
          */
        helperText: " ",
        errorText: currencyInputValid ? null : "Invalid input");

    return TextFormField(
      initialValue: viewModel.currencyAmountInput,
      decoration: inputDecoration,
      keyboardType: TextInputType.number,
      onChanged: viewModel.currencyAmountInputChanged,
      onFieldSubmitted: (_) {
        if (viewModel.convertAvailable.value) {
          viewModel.convert();
        }
      },
    );
  }
}
