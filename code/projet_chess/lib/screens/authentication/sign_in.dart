import 'package:flutter/material.dart';
import 'package:projet_chess/screens/authentication/sign_up.dart';
import 'package:projet_chess/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet_chess/widgets/loading.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final authentication = Authentication();
  bool isLoading = false;
  bool isSessionReset = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    firebaseAuth.signOut();
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      setState(() {
        isSessionReset = true;
      });
    }
      firebaseAuth.authStateChanges().listen((User? user) {
        if (mounted) {
          setState(() {
            isSessionReset = user == null;
          });
        }
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body:!isSessionReset ? const LoadingWidget() : Padding(
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
                onPressed: isLoading ? null : openSignUpPage,
                child: const Text("Créer un compte")),
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
    authentication.signIn();
    setState(() {
      isLoading = false;
    });
  }

  void openSignUpPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  void getInputs() {
    authentication.context = context;
    authentication.email = emailController.text;
    authentication.password = pwdController.text;
  }
}
