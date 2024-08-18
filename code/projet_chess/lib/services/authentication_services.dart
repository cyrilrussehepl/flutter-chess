import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/services/error_display.dart';
import '../screens/authentication/sign_in.dart';
import '../screens/main/main.dart';
import 'package:dto/user.dart' as user_dto;

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';
  String _fullName = '';
  String _username = '';
  BuildContext? _context;
  static const bool isInDebugMode = true;

  Authentication() {
    // if (isInDebugMode) {
    //   _email = 'Janja@example.com';
    //   _password = '1234567890';
    //   return;
    // }

    if (isInDebugMode) {
      _email = 'antoine@example.com';
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

  set fullName(String fullName) {
    _fullName = fullName;
  }

  set username(String username) {
    _username = username;
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (FirebaseAuth.instance.currentUser != null) return;
      if (!_context!.mounted) return;
      Navigator.of(_context!).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInPage()));
    } catch (e) {
      ErrorDisplayCustom.showError('Impossible de se déconnecter', _context!);
    }
  }

  void signIn() async {
    if (!inputsAreValid()) {
      ErrorDisplayCustom.showAuthError('empty-email', _context!);
      return;
    }
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      Navigator.pushReplacement(
          _context!, MaterialPageRoute(builder: (context) => const MainPage()));
    } on FirebaseAuthException catch (e) {
      ErrorDisplayCustom.showAuthError(e.code, _context!);
    } on ArgumentError catch (e) {
      ErrorDisplayCustom.showError(e.toString(), _context!);
    }
  }

  void signUp() async {
    if (isInDebugMode) {
      signIn();
      return;
    } else if (!inputsAreValid()) {
      return;
    }

    final userExistingWithWantedUsernameQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: _username)
        .get();

    if (userExistingWithWantedUsernameQuery.docs.isNotEmpty) {
      ErrorDisplayCustom.showAuthError('username-already-taken', _context!);
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      ErrorDisplayCustom.showAuthError(e.code, _context!);
      return;
    }

    final user = user_dto.User(
        email: _email,
        username: _username,
        usernameLowerCase: _username.toLowerCase(),
        fullName: _fullName.isEmpty ? '' : _fullName,
        nationality: '',
        friends: [],
        sentFriendRequests: [],
        receivedFriendRequests: [],
        sentChallengeRequests: [],
        receivedChallengeRequests: [],
        gamesOnGoing: [],
        gamesOver: []);
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_email.toLowerCase())
          .set(user.toJson());
    } catch (e) {
      await _auth.currentUser!.delete();
      ErrorDisplayCustom.showError(
          "Une erreur est survenue lors de la création du compte", _context!);
      return;
    }

    if (!_context!.mounted) return;
    Navigator.of(_context!).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()));
  }

  bool inputsAreValid() {
    if (emailIsEmpty()) {
      ErrorDisplayCustom.showAuthError('empty-email', _context!);
      return false;
    } else if (passwordIsEmpty()) {
      ErrorDisplayCustom.showAuthError('empty-pwd', _context!);
      return false;
    }
    return true;
  }

  bool emailIsEmpty() {
    return _email == '' || _email.isEmpty;
  }

  bool passwordIsEmpty() {
    return _password == '' || _password.isEmpty;
  }
}
