import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/services/util.dart';

import '../screens/authentication/sign_in.dart';
import '../screens/main/main.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const bool debug = true;

  static void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    } catch (e) {
      Util.showError('Impossible de se déconnecter', context);
    }
  }

  static void signIn(
      String email, String password, BuildContext context) async {
    if (debug) {
      email = 'cyril.russe@gmail.com';
      password = '123456';
    }

    if (email == '') {
      Util.showAuthError('empty-email', context);
      return;
    }
    if (password == '') {
      Util.showAuthError('empty-pwd', context);
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } on FirebaseAuthException catch (e) {
      Util.showAuthError(e.code, context);
    }
  }

  static void signUp(
      String email, String password, BuildContext context) async {
    if (debug) {
      signIn("", "", context);
      return;
    }

    if (email == '') {
      Util.showAuthError('empty-email', context);
      return;
    }
    if (password == '') {
      Util.showAuthError('empty-pwd', context);
      return;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } on FirebaseAuthException catch (e) {
      Util.showAuthError(e.code, context);
    }
  }
}
