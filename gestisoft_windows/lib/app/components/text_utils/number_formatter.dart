import 'package:intl/intl.dart';

class NumberFormater {
/*   static String format(double value) {
    return f.format(value);
  } */

  static String format(double value, int precision) {
    NumberFormat format;
    if (precision == 0) {
      format = NumberFormat("#,###", 'es_PY');
    } else {
      format = NumberFormat("#,##0.00", 'es_PY');
    }
    return format.format(value);
  }
}
