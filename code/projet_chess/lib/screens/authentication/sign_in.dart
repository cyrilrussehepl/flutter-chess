import 'package:flutter/material.dart';
import 'package:projet_chess/screens/authentication/sign_up.dart';
import 'package:projet_chess/services/authentication_services.dart';
import 'package:projet_chess/widgets/authentication/auth_button.dart';
import 'package:projet_chess/widgets/authentication/logo.dart';
import 'package:projet_chess/widgets/authentication/switch_auth_button.dart';
import 'package:projet_chess/widgets/authentication/text_input_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const LogoWidget(),
              const SizedBox(height: 40.0),
              TextInputField(
                controller: emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8.0),
              TextInputField(
                controller: pwdController,
                labelText: 'Mot de passe',
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              AuthButton(
                text: 'Se Connecter',
                onPressed: isLoading ? null : signIn,
              ),
              SwitchAuthButton(
                text: "Créer un compte",
                onPressed: isLoading ? null : openSignUpPage,
              ),
            ],
          ),
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
    Navigator.pushReplacementNamed(context, SignUpPage.routeName);
  }

  void getInputs() {
    authentication.context = context;
    authentication.email = emailController.text;
    authentication.password = pwdController.text;
  }
}
