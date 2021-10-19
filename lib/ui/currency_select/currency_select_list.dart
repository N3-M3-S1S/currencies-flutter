import 'package:currencies/model/currency.dart';
import 'package:currencies/ui/common/currency_list_item.dart';
import 'package:flutter/material.dart';

class CurrencySelectList extends StatelessWidget {
  final List<Currency> _currencies;
  final OnCurrencyClick _onCurrencySelected;
  final ScrollController? _scrollController;

  const CurrencySelectList({
    Key? key,
    ScrollController? scrollController,
    required List<Currency> currencies,
    required OnCurrencyClick onCurrencySelected,
  })  : _currencies = currencies,
        _onCurrencySelected = onCurrencySelected,
        _scrollController = scrollController,
        super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
      controller: _scrollController,
      itemCount: _currencies.length,
      itemBuilder: (context, index) {
        return CurrencyListItem(
            currency: _currencies[index], onClick: _onCurrencySelected);
      });
}
