import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/routes.dart';

import 'firebase_options.dart';
import 'screens/authentication/sign_in.dart';
import 'style/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      routes: routes,
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: mainColor,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: mainColor,
            backgroundColor: secondaryBackgroundColor,
            unselectedItemColor: Colors.grey,
          ),
          tabBarTheme: const TabBarTheme(
            indicatorColor: mainColor,
            labelColor: mainColor,
          ),
          appBarTheme: AppBarTheme(
            color: secondaryBackgroundColor,
            titleTextStyle: TextStyle(
              color: mainColor.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
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
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: mainColor,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: mainColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          searchBarTheme: SearchBarThemeData(
              backgroundColor: WidgetStateProperty.all(secondaryBackgroundColor))),
      home: const SignInPage(),
    );
  }
}
