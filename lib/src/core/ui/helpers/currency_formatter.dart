// Crie um formato de moeda BRL (R$)
import 'package:intl/intl.dart';

String formatCurrency(double? value) {
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  return currencyFormat.format(value ?? 0);
}
