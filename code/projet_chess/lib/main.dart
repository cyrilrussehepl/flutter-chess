import 'package:flutter/material.dart';
import 'screens/authentication/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.green,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.green,
            backgroundColor: Colors.blueGrey[50],
            unselectedItemColor: Colors.grey,
          ),
          tabBarTheme: const TabBarTheme(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
          ),
          appBarTheme: AppBarTheme(
            color: Colors.blueGrey[50],
            titleTextStyle: TextStyle(
              color: Colors.green.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            iconTheme: const IconThemeData(
              color: Colors.green,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.green),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          searchBarTheme: SearchBarThemeData(
              backgroundColor: WidgetStateProperty.all(Colors.blueGrey[50]))),
      home: const SignInPage(),
    );
  }
}
