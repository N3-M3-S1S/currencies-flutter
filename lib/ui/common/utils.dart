import 'dart:math';

bool doubleHasDecimalPart(double d) => d % 1 != 0;

String doubleToPrettyString(double d,
    [int digitsAfterDecimalPointAndLeadingZeros = 2]) {
  assert(!digitsAfterDecimalPointAndLeadingZeros.isNegative);
  if (d == double.infinity) {
    return d.toString();
  }
  //if we don't want to have decimal part in the result string or the input decimal doesn't have decimal part, just return a whole number string
  if (digitsAfterDecimalPointAndLeadingZeros == 0 || !doubleHasDecimalPart(d)) {
    return d.truncate().toString();
  } else {
    //remove whole part from the decimal e.g 5.0023 becomes 0.0023
    final decimalPart = d - d.truncate();
    //count leading zeros after decimal point e.g. for 0.0023 this should retutn 2
    final leadingZerosAfterDecimalPoint =
        ((log(decimalPart) / ln10) + 1).floor().abs();
    return d.toStringAsFixed(
        leadingZerosAfterDecimalPoint + digitsAfterDecimalPointAndLeadingZeros);
  }
}
