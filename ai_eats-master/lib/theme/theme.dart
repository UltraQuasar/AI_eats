import 'package:flutter/material.dart';

const Color white = Colors.white;
const Color lightGrey = Color.fromRGBO(150, 150, 150, 1);
const Color grey = Color.fromRGBO(88, 88, 88, 1);
const Color darkGrey = Color.fromRGBO(33, 33, 33, 1);
const Color black = Colors.black;
const Color darkBrown = Color.fromRGBO(36, 19, 3, 1);
const Color brown = Color.fromRGBO(59, 32, 6, 1);
const Color lightBrown = Color.fromRGBO(121, 98, 54, 1);
const Color lightGreen = Color.fromRGBO(151, 161, 92, 1);
const Color green = Colors.lightGreen;
const Color yellow = Color.fromRGBO(240, 232, 105, 1);
const Color red = Colors.red;
const Color gold = Colors.amberAccent;

// ------------------------------ Light-Mode ------------------------------ //

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: black,
    disabledColor: white,
    scaffoldBackgroundColor: white,
    cardColor: Colors.grey.shade200,
    bottomAppBarColor: Color.fromRGBO(70, 70, 70, 1),
    appBarTheme: const AppBarTheme(color: white, titleTextStyle: TextStyle(color: black))
);


// ------------------------------ Dark-Mode ------------------------------ //


ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: white,
    disabledColor: lightGrey,
    scaffoldBackgroundColor: darkGrey,
    cardColor: Colors.grey.shade800,
    bottomAppBarColor: Colors.white70,
    appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(color: white)),
);
