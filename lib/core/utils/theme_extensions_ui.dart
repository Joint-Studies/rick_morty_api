import 'package:flutter/material.dart';

extension ThemeExtensionsUi on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle get titleStyle => TextStyle(
        fontSize: 25,
        fontFamily: 'WubbaLubbaDubDub',
        fontWeight: FontWeight.bold,
      );
  TextStyle get commonTextStyle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      );
}
