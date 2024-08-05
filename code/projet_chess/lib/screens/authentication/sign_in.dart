import 'package:flutter/material.dart';
import 'package:projet_chess/screens/authentication/sign_up.dart';
import 'package:projet_chess/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet_chess/services/util.dart';
import '../main/main.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final authentication = Authentication();
  bool isLoading = false;

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
              onPressed: isLoading ? null : signIn,
              child: const Text('Se Connecter'),
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

  void signIn() async {
    setState(() {
      isLoading = true;
    });
    getInputs();
    try {
      authentication.signIn();
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Util.showAuthError(e.code, context);
    }
  }

  void getInputs() {
    authentication.email = emailController.text;
    authentication.password = pwdController.text;
  }
}
