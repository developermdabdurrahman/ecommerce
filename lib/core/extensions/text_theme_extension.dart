import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext{
  TextTheme get textTheme{
    return Theme.of(this).textTheme;
  }
}