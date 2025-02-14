import 'package:intl/intl.dart';

currencyFormat(double amount) {
  final f = NumberFormat("#,###");
  return f.format(amount);
}
