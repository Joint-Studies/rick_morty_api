import 'package:flutter/material.dart';

import '../../../core/utils/theme_extensions_ui.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ElevatedButtonCustom({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        child: Text(
          text,
          style: context.titleStyle,
        ),
      ),
    );
  }
}
