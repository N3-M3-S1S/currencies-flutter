import 'package:currencies/model/currency.dart';
import 'package:currencies/ui/common/currency_list_item.dart';
import 'package:currencies/ui/common/utils.dart';
import 'package:flutter/widgets.dart';

class ExchangeRatesList extends StatelessWidget {
  final Map<Currency, double> _exchangeRates;

  const ExchangeRatesList(
      {Key? key, required Map<Currency, double> exchangeRates})
      : _exchangeRates = exchangeRates,
        super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: _exchangeRates.length,
      itemBuilder: (context, index) {
        final currency = _exchangeRates.keys.elementAt(index);
        final exchangeRate = _exchangeRates[currency]!;
        return CurrencyListItem(
            currency: currency,
            trailing: Text(
              doubleToPrettyString(exchangeRate),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ));
      });
}
