import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
  ),
  primarySwatch: Colors.deepOrange,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    elevation: 0.0,
    centerTitle: true,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[900],
        statusBarIconBrightness: Brightness.light),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    unselectedItemColor: Colors.white,
    backgroundColor: Colors.grey[900],
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
  ),
);
