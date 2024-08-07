// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:projet_chess/services/authentication.dart';
// import 'package:dto/user.dart' as userDTO;

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

  // final auth = FirebaseAuth.instance;
  // String? email = 'grace@example.com';
  // const password = '1234567890';
  // await auth.signInWithEmailAndPassword(email: email, password: password);
  // final firestore = FirebaseFirestore.instance;
  // email = FirebaseAuth.instance.currentUser?.email;
  //
  // try {
  //   DocumentSnapshot documentSnapshot =
  //       await firestore.collection('users').doc(email).get();
  //
  //   if (documentSnapshot.exists) {
  //     print("doc exists");
  //     Map<String, dynamic> data =
  //         documentSnapshot.data() as Map<String, dynamic>;
  //     userDTO.User user = userDTO.User.fromJson(data);
  //     print(user.toString());
  //   }
  // } catch (e) {
  //   print('Error fetching user: $e');
  // }
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
            backgroundColor: Colors.blueGrey[50]),
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.green,
          labelColor: Colors.green,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey[50], // Couleur de fond de l'AppBar
          titleTextStyle: TextStyle(
            color: Colors.green.withOpacity(0.8), // Couleur du texte
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: const IconThemeData(
            color: Colors.green, // Couleur des icônes
          ),
          elevation: 0, // Optionnel : Retire l'ombre pour un look plus plat
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
      ),
      home: SignInPage(),
    );
  }
}
