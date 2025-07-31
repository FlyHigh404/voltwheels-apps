import 'package:intl/intl.dart';

String formatDigit(String number) {
  int value = int.parse(number);

  final NumberFormat formatter = NumberFormat("#,###", "en_US");

  return formatter.format(value).replaceAll(",", ".");
}