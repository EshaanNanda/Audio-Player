import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade300,
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade200,
        inversePrimary: Colors.grey.shade900),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: Colors.grey.shade800,
      displayColor: Colors.black,
    )
);
