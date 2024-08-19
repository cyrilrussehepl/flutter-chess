import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/screens/authentication/sign_up.dart';
import 'package:projet_chess/services/authentication_services.dart';
import 'package:projet_chess/widgets/loading.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in';

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
    final User? user = firebaseAuth.currentUser;
    await firebaseAuth.signOut();

    if (user == null) {
      setState(() {
        isSessionReset = true;
      });
      return;
    }

    firebaseAuth.authStateChanges().listen((User? user) {
      setState(() {
        isSessionReset = user == null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: !isSessionReset
          ? const LoadingWidget()
          : SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                  ))),
    );
  }

  void signIn() async {
    isLoading = true;
    getInputs();
    authentication.signIn();
    isLoading = false;
  }

  void openSignUpPage() {
    Navigator.pushNamed(context, SignUpPage.routeName);

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => SignUpPage()),
    // );
  }

  void getInputs() {
    authentication.context = context;
    print(emailController.text);
    print(pwdController.text);
    authentication.email = emailController.text;
    authentication.password = pwdController.text;
  }
}
