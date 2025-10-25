import 'package:flutter/material.dart';

ThemeData lightMode= ThemeData(
brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade700, // main accent color
    secondary: Colors.grey.shade100, // for secondary elements
    surface: const Color.fromARGB(215, 224, 224, 224), // card/bg color
    tertiary: Colors.white, // optional third color
    inversePrimary: Colors.grey.shade700, // for text/icons on primary bg

)
);

