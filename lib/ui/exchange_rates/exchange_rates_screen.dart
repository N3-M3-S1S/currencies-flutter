import 'package:currencies/ui/exchange_rates/exhange_rates_state_display.dart';
import 'package:flutter/material.dart';

import 'exchange_rates_base_currency_button.dart';

class ExchangeRatesScreen extends StatelessWidget {
  const ExchangeRatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: const [
            Padding(
                padding: EdgeInsets.all(16),
                child: ExchangeRatesBaseCurrencyButton()),
            SizedBox(height: 8),
            Expanded(child: ExchangeRatesStateDisplay())
          ],
        ));
  }
}
