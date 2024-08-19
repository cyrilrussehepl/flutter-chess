import 'package:flutter/material.dart';
import 'package:projet_chess/screens/authentication/sign_in.dart';
import 'package:projet_chess/services/authentication_services.dart';
import 'package:projet_chess/widgets/authentication/auth_button.dart';
import 'package:projet_chess/widgets/authentication/logo.dart';
import 'package:projet_chess/widgets/authentication/switch_auth_button.dart';
import 'package:projet_chess/widgets/authentication/text_input_field.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/sign_up';

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
              minHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const LogoWidget(),
                const SizedBox(height: 40.0),
                TextInputField(
                  controller: usernameController,
                  labelText: 'Username',
                ),
                const SizedBox(height: 8.0),
                TextInputField(
                  controller: fullNameController,
                  labelText: 'Full Name',
                ),
                const SizedBox(height: 8.0),
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
                  text: 'Créer un compte',
                  onPressed: () => signUp(context),
                ),
                SwitchAuthButton(
                  text: "J'ai déjà un compte",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, SignInPage.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
