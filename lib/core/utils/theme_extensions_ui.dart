import 'package:flutter/material.dart';

extension ThemeExtensionsUi on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle get titleStyle => TextStyle(
        fontSize: 25,
        fontFamily: 'WubbaLubbaDubDub',
        fontWeight: FontWeight.bold,
      );
}
