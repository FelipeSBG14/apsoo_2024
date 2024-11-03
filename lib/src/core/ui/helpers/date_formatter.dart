import 'package:intl/intl.dart';

class DateFormatter {
  /// Formata a data para o formato MM-dd-yyyy.
  static String format(DateTime? date) {
    return DateFormat('dd-MM-yyyy').format(date!);
  }
}
