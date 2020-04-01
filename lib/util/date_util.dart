import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  static DateTime trunc(DateTime dateTime) {
    return DateTime.utc(dateTime.year, dateTime.month, dateTime.day);
  }

  static String toPtBr(DateTime date) {
    return dateFormat.format(date);
  }
}
