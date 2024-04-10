import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: Color(0xFFFFDB08),
  secondaryHeaderColor: Color(0xFF861710),
  disabledColor: Color(0xFF6f7275),
  errorColor: Color(0xFFdd3135),
  brightness: Brightness.dark,
  hintColor: Color(0xFFbebebe),
  cardColor: Colors.black,
  colorScheme: ColorScheme.dark(
      primary: Color(0xFFFFDB08), secondary: Color(0xFF861710)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Color(0xFFFFDB08))),
);
