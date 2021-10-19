import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'converter_currency_buttons.dart';
import 'converter_swap_currencies_button.dart';

class CurrencySelectPanel extends StatelessWidget {
  const CurrencySelectPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        CurrencyFromSelectButton(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SwapCurrenciesButton(),
        ),
        CurrencyToSelectButton()
      ],
    );
  }
}

