import 'package:currencies/model/currency.dart';
import 'package:flutter/widgets.dart';

class CurrencyFlagImage extends StatelessWidget {
  final double width;
  final double height;
  final Currency currency;
  static const String _currencyFlagImagesPath = "assets/flags";
  static const String _unknownCurrencyFlagImagePath =
      "$_currencyFlagImagesPath/unknown.png";

  const CurrencyFlagImage({
    Key? key,
    required this.width,
    required this.height,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Image.asset(_currencyFlagImagePath(currency),
          width: width,
          height: height,
          errorBuilder: (_, __, ___) => _buildImageLoadErrorWidget());

  String _currencyFlagImagePath(Currency currency) =>
      "$_currencyFlagImagesPath/${currency.code}.png";

  Widget _buildImageLoadErrorWidget() => Image.asset(
        _unknownCurrencyFlagImagePath,
        width: width,
        height: height,
      );
}
