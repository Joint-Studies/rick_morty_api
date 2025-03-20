import 'package:flutter/material.dart';

class ThemeDataUi {
  ThemeDataUi._();

  static ThemeData get theme => ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4DB6AC),
            elevation: 5,
            shadowColor: Color(0xFF166D3B),
            side: BorderSide(
              width: 3,
              color: Color(0xFF9CCC65),
            ),
          ),
        ),
      );
}
