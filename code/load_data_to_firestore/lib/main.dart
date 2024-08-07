import 'package:dto/user.dart';
import 'package:firedart/firedart.dart';
import 'package:load_data_to_firestore/users.dart';

String pi = 'flutter-chess-1af50';
String apiKey = 'AIzaSyBheqTFJwxXUcv6zbGGIjpVkVqHuBwJqD0';

List<String> teamsId = [];

Future<void> main(List<String> arguments) async {
  Firestore.initialize(pi);
  late TokenStore tokenStore;

  tokenStore = VolatileStore();
  FirebaseAuth(apiKey, tokenStore);
  FirebaseAuth.initialize(apiKey, tokenStore);

  await addUsers();
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
