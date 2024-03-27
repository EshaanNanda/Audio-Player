import 'package:flutter/material.dart';

ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.grey.shade900,
        primary: Colors.grey.shade600,
        secondary: Colors.grey.shade800,
        inversePrimary: Colors.grey.shade300),
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: Colors.grey.shade300,
      displayColor: Colors.black,
    )
);
