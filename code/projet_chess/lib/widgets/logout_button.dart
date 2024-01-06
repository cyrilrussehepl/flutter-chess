import 'package:flutter/material.dart';
import 'package:projet_chess/services/authentication.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.logout_rounded),
        tooltip: 'Déconnexion',
        onPressed: () => Authentication.signOut(context));
  }
}
