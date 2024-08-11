import 'dart:io';

import 'package:dto/user.dart';
import 'package:dto/game.dart';
import 'package:firedart/firedart.dart';
import 'package:load_data_to_firestore/users.dart';
import 'package:load_data_to_firestore/games.dart';

String pi = 'flutter-chess-1af50';
String apiKey = 'AIzaSyBheqTFJwxXUcv6zbGGIjpVkVqHuBwJqD0';

List<String> teamsId = [];

bool done = false;

Future<void> main(List<String> arguments) async {
  Firestore.initialize(pi);
  late TokenStore tokenStore;

  tokenStore = VolatileStore();
  FirebaseAuth(apiKey, tokenStore);
  FirebaseAuth.initialize(apiKey, tokenStore);

  await addUsers();
  await addGames();
  if(done) {
    print("done");
    exit(0);
  }
}

Future<void> addUsers() async {
  for (User user in users) {
    await Firestore.instance
        .collection('users')
        .document(user.email.toLowerCase())
        .set(user.toJson());
    try {
      await FirebaseAuth.instance.signUp(user.email, '1234567890');
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<void> addGames() async {
  for (Game game in games) {
    print(game.gameId);
    await Firestore.instance
        .collection('games')
        .document(game.gameId)
        .set(game.toJson());
  }
  done = true;
}
