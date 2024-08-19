import 'package:flutter/material.dart';

import 'color.dart';

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    color: mainColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: mainColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: mainColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle bodyTextSecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle label = TextStyle(
    color: mainColor,
  );

  static const TextStyle gameHeading = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  );
}
