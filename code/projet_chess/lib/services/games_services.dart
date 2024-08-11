import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/game.dart';
import 'user_services.dart';

class GameService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final GameService _instance = GameService._internal();
  static String? username;

  GameService._internal();

  static GameService get instance => _instance;

  void refreshUsername() async {
    final user = await UserService.instance.getUser();
    username = user.username;
  }

  Stream<Game?> getGameStream(String gameId) {
    print("oui");
    return _db
        .collection('games')
        .doc(gameId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        Game game = Game.fromJson(snapshot.data()!);
        print("snapshot exists\n\n");
        return game;
      } else {
        print("snapshot doesn't exist!\n\n");
        return null;
      }
    });
  }

  }