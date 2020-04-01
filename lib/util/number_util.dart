import 'package:intl/intl.dart';

class NumberUtil {
  static final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt-br', symbol: '');

  static String toCurrency(dynamic value) => currencyFormat.format(value);
}
