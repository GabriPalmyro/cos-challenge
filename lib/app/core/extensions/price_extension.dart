import 'package:intl/intl.dart';

extension PriceExtension on double {
  String toCurrency() {
    return NumberFormat.currency(
      locale: 'de_DE',
      symbol: '€',
      decimalDigits: 2,
    ).format(this);
  }
}
