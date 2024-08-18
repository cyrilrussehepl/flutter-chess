import 'package:flutter/material.dart';
import 'package:projet_chess/screens/authentication/sign_in.dart';
import 'package:projet_chess/services/authentication_services.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inscription'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Image(
                    image: AssetImage('assets/asyncChessLogo.png'),
                    height: 150,
                  ),
                  const Center(
                      child: Text(
                    'AsyncChess',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  )),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8.0),
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
                    onPressed: () => signUp(context),
                  ),
                  TextButton(
                    child: const Text("J'ai déjà un compte"),
                    onPressed: () {
                      // Navigate to Sign in page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void signUp(BuildContext context) {
    getInputs(context);
    authentication.signUp();
  }

  void getInputs(BuildContext context) {
    authentication.email = emailController.text;
    authentication.password = pwdController.text;
    authentication.username = usernameController.text;
    authentication.fullName = fullNameController.text;
    authentication.context = context;
  }
}
