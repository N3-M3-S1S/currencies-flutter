import 'package:currencies/model/currency.dart';
import 'package:currencies/ui/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConverterResult extends StatelessWidget {
  final Currency _fromCurrency;
  final double _fromCurrencyAmount;
  final Currency _toCurrency;
  final double _toCurrencyConversionResult;
  final double _exchangeRate;

  const ConverterResult({
    Key? key,
    required fromCurrency,
    required fromCurrencyAmount,
    required toCurrency,
    required toCurrencyConversionResult,
    required exchangeRate,
  })  : _fromCurrency = fromCurrency,
        _fromCurrencyAmount = fromCurrencyAmount,
        _toCurrency = toCurrency,
        _toCurrencyConversionResult = toCurrencyConversionResult,
        _exchangeRate = exchangeRate,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildConversionResultTitle(context),
        const SizedBox(height: 8),
        _buildConversionResultText(context),
        const SizedBox(height: 8),
        _buildExchangeRatesText(context)
      ],
    );
  }

  Widget _buildConversionResultTitle(BuildContext context) {
    return Text("Conversion result",
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.bold));
  }

  Widget _buildConversionResultText(BuildContext context) {
    //keep currency amount like original input
    final fromCurrencyAmountString = doubleHasDecimalPart(_fromCurrencyAmount)
        ? _fromCurrencyAmount.toString()
        : _fromCurrencyAmount.truncate().toString();
    final toCurrencyAmountString =
        doubleToPrettyString(_toCurrencyConversionResult);
    final text = _buildConversionResultString(
        fromCurrencyAmountString, toCurrencyAmountString);
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildExchangeRatesText(BuildContext context) {
    final exchangeRateString = doubleToPrettyString(_exchangeRate);
    final text = _buildConversionResultString("1", exchangeRateString);
    return Text(text, style: Theme.of(context).textTheme.subtitle2!);
  }

  String _buildConversionResultString(
          String fromCurrencyString, String toCurrencyString) =>
      "$fromCurrencyString ${_fromCurrency.code.toUpperCase()} = $toCurrencyString ${_toCurrency.code.toUpperCase()}";
}
