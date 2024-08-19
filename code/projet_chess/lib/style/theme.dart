import 'package:flutter/material.dart';

import 'color.dart';
import 'text_styles.dart';

final theme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: mainColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: mainColor,
    backgroundColor: secondaryBackgroundColor,
    unselectedItemColor: Colors.grey,
  ),
  tabBarTheme: TabBarTheme(
    indicatorColor: mainColor,
    labelColor: mainColor,
  ),
  appBarTheme: AppBarTheme(
    color: secondaryBackgroundColor,
    titleTextStyle: AppTextStyles.appBarTitle,
    iconTheme: const IconThemeData(
      color: mainColor,
    ),
    elevation: 0,
  ),
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: mainColor,
      foregroundColor: Colors.white,
      textStyle: AppTextStyles.buttonText,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: mainColor,
      textStyle: AppTextStyles.buttonText,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: AppTextStyles.label,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: mainColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
  searchBarTheme: SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(secondaryBackgroundColor),
  ),
);
