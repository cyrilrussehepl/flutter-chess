import 'dart:math';

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
    return _db
        .collection('games')
        .doc(gameId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        Game game = Game.fromJson(snapshot.data()!);
        return game;
      } else {
        return null;
      }
    });
  }

  Future<String> createGame(String username, String opponentUsername) async {
    bool isUserWhite = Random().nextBool();
    final docRef = await _db.collection('games').doc();
    final newGame = Game(gameId: docRef.id,
        playerWhite: isUserWhite ? username : opponentUsername,
        playerBlack: !isUserWhite ? username : opponentUsername,
        currentTurn: 'white',
        gameState: 'ongoing',
        boardState: [
          'r', 'n', 'b', 'q', 'k', 'b', 'n', 'r',
          'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p',
          null, null, null, null, null, null, null, null,
          null, null, null, null, null, null, null, null,
          null, null, null, null, null, null, null, null,
          null, null, null, null, null, null, null, null,
          'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P',
          'R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R',
        ],
        moves: []);

    docRef.set(newGame.toJson());

    return docRef.id;
  }

  void makeAMove(Game game) async {
    _db.collection('games')
        .doc(game.gameId)
        .set(game.toJson());

    if(game.gameState!='onGoing')
      UserService.instance.updateGameOver(game.gameId);
  }



}