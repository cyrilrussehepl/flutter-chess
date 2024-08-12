import 'package:flutter/material.dart';
import 'package:projet_chess/services/games_services.dart';
import 'package:projet_chess/widgets/chess/chess.dart';
import 'package:dto/game.dart';
import 'package:projet_chess/widgets/loading.dart';

class GameScreen extends StatelessWidget {
  final String gameId;
  final String opponentUsername;

  GameScreen({super.key, required this.gameId, required this.opponentUsername});

  @override
  Widget build(BuildContext context) {
    final gameService = GameService.instance;
    return StreamBuilder(
        stream: gameService.getGameStream(gameId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapshot.hasError ||
              (snapshot.hasData && snapshot.data == null)) {
            return const Center(
              child: Text(
                  'Une erreur est survenue lors du chargement de la partie'),
            );
          }

          Game game = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text('Partie ${game.playerWhite} vs ${game.playerBlack}'),
            ),
            body: Column(
              children: [
                if (game.gameState == 'ongoing')
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Trait aux ' +
                            (game.currentTurn == 'white' ? 'blancs' : 'noirs') +
                            (((game.currentTurn == 'white' &&
                                        game.playerWhite != opponentUsername) ||
                                    (game.currentTurn == 'black' &&
                                        game.playerBlack != opponentUsername))
                                ? '\nÀ vous de jouer'
                                : '\nEn attente du tour de votre adversaire...'),
                      )),
                if (game.gameState != 'ongoing')
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'La partie est terminée: ${game.gameState}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: ChessGame(game: game),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
