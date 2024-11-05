import 'package:flutter/services.dart';

TextInputFormatter decimalInputFormatter({int decimalPlaces = 2}) {
  return FilteringTextInputFormatter.allow(
    RegExp(r'^\d*\.?\d{0,' + decimalPlaces.toString() + r'}'),
  );
}
