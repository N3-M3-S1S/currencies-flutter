import 'package:currencies/model/currency.dart';
import 'package:flutter/material.dart';

import 'currency_flag_image.dart';

typedef OnCurrencyClick = Function(Currency);

class CurrencyListItem extends StatelessWidget {
  final Currency _currency;
  final Widget? _trailing;
  final OnCurrencyClick? _onCurrencyClick;

  const CurrencyListItem({
    Key? key,
    required Currency currency,
    Widget? trailing,
    OnCurrencyClick? onClick,
  })  : _currency = currency,
        _trailing = trailing,
        _onCurrencyClick = onClick,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final onTap =
        _onCurrencyClick != null ? () => _onCurrencyClick!(_currency) : null;
    return ListTile(
      onTap: onTap,
      leading: CurrencyFlagImage(currency: _currency, width: 40, height: 40),
      title: Text(_currency.name),
      subtitle: Text(_currency.code.toUpperCase()),
      trailing: _trailing,
    );
  }
}
