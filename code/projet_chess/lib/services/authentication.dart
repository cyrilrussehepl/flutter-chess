import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/services/util.dart';
import '../screens/authentication/sign_in.dart';
import '../screens/main/main.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';
  late final BuildContext _context;
  static const bool isInDebugMode = true;

  Authentication() {
    if (isInDebugMode) {
      _email = 'Grace@example.com';
      _password = '1234567890';
    }
  }

  set email(String email) {
    if (isInDebugMode) return;
    _email = email;
  }

  set password(String password) {
    if (isInDebugMode) return;
    _password = password;
  }

  set context(BuildContext context) {
    _context = context;
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!_context.mounted) return;
      Navigator.of(_context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInPage()));
    } catch (e) {
      Util.showError('Impossible de se déconnecter', _context);
    }
  }

  void signIn() async {
    if (!inputsAreValid()) return;

    await _auth.signInWithEmailAndPassword(email: _email, password: _password);
  }

  void signUp() async {
    if (isInDebugMode) {
      signIn();
      return;
    } else if (!inputsAreValid()) {
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      if (!_context.mounted) return;
      Navigator.of(_context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
    } on FirebaseAuthException catch (e) {
      Util.showAuthError(e.code, _context);
    }
  }

  bool inputsAreValid() {
    if (emailIsEmpty()) {
      Util.showAuthError('empty-email', _context);
      return false;
    } else if (passwordIsEmpty()) {
      Util.showAuthError('empty-pwd', _context);
      return false;
    }
    return true;
  }

  bool emailIsEmpty() {
    return _email == '';
  }

  bool passwordIsEmpty() {
    return _password == '';
  }
}
