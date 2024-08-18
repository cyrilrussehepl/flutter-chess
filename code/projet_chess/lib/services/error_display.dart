import 'package:flutter/material.dart';

class ErrorDisplayCustom {
  static void showAuthError(String errorCode, BuildContext context) {
    String msg = "Error";
    switch (errorCode) {
      case 'email-already-in-use':
        msg = 'Un compte utilisant cette adresse mail existe déjà.';
      case 'weak-password':
        msg = 'Veuillez entrer un mot de passe de 6 caractères minimum.';
      case 'empty-pwd':
        msg = 'Veuillez entrer un mot de passe.';
      case 'empty-email':
        msg = 'Remplissez tous les champs.';
      case 'invalid-email':
        msg = 'Veuillez entrer une adresse mail valide.';
      case 'user-not-found':
        msg =
            'L\'adresse mail que vous avez entrée n\'est associée à aucun compte.';
      case 'wrong-password':
        msg = 'Mot de passe incorrect.';
      case 'too-many-requests':
        msg =
            'Vous avez fait trop de tentatives. Veuillez réessayer plus tard.';
      case 'invalid-credential':
        msg = 'Adresse mail ou mot de passe incorrect.';
      case 'username-already-taken':
        msg =
            'Le nom d\'utilisateur entré est déjà utilisé. Veuillez en choisir un autre.';
      default:
        msg = 'Error';
    }
    showError(msg, context);
  }

  static void showMsg(String msg, BuildContext context) {
    final snackBar = SnackBar(
        showCloseIcon: true,
        duration: const Duration(seconds: 10),
        content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showError(String msg, BuildContext context) {
    showMsg(msg, context);
  }
}
