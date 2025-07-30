import 'package:flutter/material.dart';

extension DateTimeExtensions on BuildContext {
  DateTime get now => DateUtils.dateOnly(DateTime.now());
}
