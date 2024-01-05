import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/screens/sign_up_page.dart';
import 'home_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final bool debug = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: pwdController,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              child: const Text('Se Connecter'),
              onPressed: () => loginController(context),
            ),
            TextButton(
              child: const Text("Créer un compte"),
              onPressed: () {
                // Navigate to the Create Account Page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void loginController(BuildContext context) async {
    if (debug) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      return;
    }

    if (emailController.text == '') {
      showError('empty-email', context);
      return;
    }
    if (pwdController.text == '') {
      showError('empty-pwd', context);
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: pwdController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      showError(e.code, context);
    }
  }

  void showError(String txt, BuildContext context) {
    String msg = "Error";
    switch (txt) {
      case 'user-not-found':
        msg =
            'L\'adresse mail que vous avez entrée n\'est associée à aucun compte .';
      case 'wrong-password':
        msg = 'Mot de passe incorrect.';
      case 'empty-pwd':
        msg = 'Veuillez entrer un mot de passe.';
      case 'empty-email':
        msg = 'veuillez entrer une adresse mail.';
      case 'invalid-email':
        msg = 'Veuillez entrer une adresse mail valide.';
      case 'too-many-requests':
        msg =
            'Vous avez fait trop de tentatives. Veuillez réessayer plus tard.';
      case 'invalid-credential':
        msg = 'Adresse mail ou mot de passe incorrect';
    }
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
