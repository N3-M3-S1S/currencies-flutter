import 'package:currencies/model/currency.dart';
import 'package:flutter/material.dart';

class CurrencyDropdownTextFieldButton extends StatelessWidget {
  final String _title;
  final Currency _currency;
  final GestureTapCallback _onClick;

  const CurrencyDropdownTextFieldButton({
    Key? key,
    required String title,
    required Currency currency,
    required GestureTapCallback onClick,
  })  : _title = title,
        _currency = currency,
        _onClick = onClick,
        super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: TextEditingController(text: _currency.code.toUpperCase()),
        decoration: InputDecoration(
            labelText: _title, suffixIcon: const Icon(Icons.expand_more)),
        readOnly: true,
        onTap: _onClick,
        enableInteractiveSelection: false,
      );
}
