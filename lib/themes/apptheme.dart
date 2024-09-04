import 'package:flutter/material.dart';

ThemeData darkTheme=ThemeData(
  brightness: Brightness.dark,
  colorScheme:  ColorScheme.light(brightness: Brightness.dark,
  background: Colors.grey.shade900,
    primary: Colors.purple.shade900,
    secondary:Colors.white

  )
);
ThemeData lightTheme=ThemeData(
  brightness: Brightness.light,
  colorScheme:  ColorScheme.light(brightness: Brightness.light,
  background: Colors.grey.shade100,
  primary: Colors.purple.shade600,
  secondary:Colors.black)

);

