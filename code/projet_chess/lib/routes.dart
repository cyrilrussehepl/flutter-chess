import 'package:flutter/cupertino.dart';
import 'package:projet_chess/screens/authentication/sign_in.dart';
import 'package:projet_chess/screens/authentication/sign_up.dart';
import 'package:projet_chess/screens/main/main.dart';

Map<String, WidgetBuilder> routes = {
  SignInPage.routeName: (context) => const SignInPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  MainPage.routeName: (context) => const MainPage(),
};
