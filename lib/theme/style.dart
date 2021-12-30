import 'package:flutter/material.dart';

ThemeData style() {
  return ThemeData(
    primaryColor: Colors.blueGrey[500],
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colors.black,
    ).copyWith(
      secondary: Colors.lightBlueAccent[700],
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.blueGrey[500],
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey[500],
      ),
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey[500]),
  );
}
