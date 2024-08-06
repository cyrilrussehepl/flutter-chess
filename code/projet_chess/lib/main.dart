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

  // late final Stream<DocumentSnapshot<userDTO.User>>? _userStream;
  // _userStream = FirebaseFirestore.instance
  //     .collection('users')
  //     .withConverter<userDTO.User>(
  //       fromFirestore: (snapshot, _)=>userDTO.User.fromJson(snapshot.data()!),
  //       toFirestore: (user, _)=>user.toJson()
  //     )
  //     .doc('user')
  //     .snapshots();

  // Lire un document par son ID

  // FirebaseFirestore db = FirebaseFirestore.instance;
  //
  // await db.collection('users').doc('user').update({'email': 'test2@gmail.com'});
  // DocumentSnapshot documentSnapshot = await db.collection('users').doc('user').get();
  // if (documentSnapshot.exists) {
  //   Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //   print('email:${data['email']}');
  //
  // } else {
  //   print('Document does not exist');
  // }

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
        appBarTheme: AppBarTheme(color: Colors.blueGrey[50]),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignInPage(),
    );
  }
}
