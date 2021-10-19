import 'package:currencies/ui/common/utils.dart';
import 'package:flutter_test/flutter_test.dart';

@TestOn("vm")
main() {
  test("Double has decimal part", () {
    const doubleWithDecimalPart = 1.1;
    expect(doubleHasDecimalPart(doubleWithDecimalPart), true);
  });

  test("Double doesn't have decimal part", () {
    const double doubleWithoutDecimalPart = 1;
    expect(doubleHasDecimalPart(doubleWithoutDecimalPart), false);
  });

  test("Double pretty string with leading zeros", () {
    const doubleWithLeadingZeros = 1.001234;
    const expectedString = "1.001";
    final result = doubleToPrettyString(doubleWithLeadingZeros, 1);
    expect(result, expectedString);
  });

  test("Double pretty string without leading zeros", () {
    const doubleWithLeadingZeros = 0.1234;
    const expectedString = "0.123";
    final result = doubleToPrettyString(doubleWithLeadingZeros, 3);
    expect(result, expectedString);
  });

  test("Double pretty string without decimal part", () {
    const double doubleWithLeadingZeros = 123;
    const expectedString = "123";
    final result = doubleToPrettyString(doubleWithLeadingZeros, 3);
    expect(result, expectedString);
  });
}
