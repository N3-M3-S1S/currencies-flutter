import 'package:currencies/ui/converter/converter_convert_button.dart';
import 'package:flutter/material.dart';

import 'converter_currency_amount_input.dart';
import 'converter_currency_select_panel.dart';
import 'converter_state_display.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(16),
              child: Column(children: const [
                CurrencySelectPanel(),
                SizedBox(height: 16),
                CurrencyAmountInput(),
                Align(alignment: Alignment.centerRight, child: ConvertButton()),
                SizedBox(height: 16),
                Expanded(child: ConverterStateDisplay())
              ])))
    ]);
  }
}
