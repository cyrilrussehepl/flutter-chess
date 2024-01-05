import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/screens/home_page.dart';
import 'package:projet_chess/screens/sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final bool debug = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
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
                child: const Text('Créer un compte'),
                onPressed: () => createAccountController(context)),
            TextButton(
              child: const Text("J'ai déjà un compte"),
              onPressed: () {
                // Navigate to Sign in page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void createAccountController(BuildContext context) async {
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
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
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
      case 'email-already-in-use':
        msg = 'Un compte utilisant cette adresse mail existe déjà';
      case 'weak-password':
        msg = 'Veuillez entrer un mot de passe de 6 caractères minimum';
      case 'empty-pwd':
        msg = 'Veuillez entrer un mot de passe';
      case 'empty-email':
        msg = 'Remplissez tous les champs';
      case 'invalid-email':
        msg = 'Veuillez entrer une adresse mail valide';
    }
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
