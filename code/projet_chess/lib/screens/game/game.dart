import 'package:dto/game.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/services/games_services.dart';
import 'package:projet_chess/widgets/chess/chess.dart';
import 'package:projet_chess/widgets/loading.dart';
import 'package:projet_chess/style/text_styles.dart';

class GameScreen extends StatelessWidget {
  final String gameId;
  final String opponentUsername;

  GameScreen({super.key, required this.gameId, required this.opponentUsername});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partie contre $opponentUsername'),
      ),
      body: _buildGameStream(),
    );
  }

  Widget _buildGameStream() {
    final gameService = GameService.instance;

    return StreamBuilder<Game?>(
      stream: gameService.getGameStream(gameId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child:
                Text('Une erreur est survenue lors du chargement de la partie'),
          );
        }

        Game game = snapshot.data!;

        return Column(
          children: [
            if (game.gameState == 'ongoing')
              _buildTurnInfo(game)
            else
              _buildGameOverInfo(game),
            Expanded(
              child: Center(
                child: ChessGame(
                  key: ValueKey(game.gameState + game.currentTurn),
                  game: game,
                  opponentUsername: opponentUsername,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTurnInfo(Game game) {
    final isYourTurn = (game.currentTurn == 'white' &&
            game.playerWhite != opponentUsername) ||
        (game.currentTurn == 'black' && game.playerBlack != opponentUsername);
    final turnText =
        'Trait aux ' + (game.currentTurn == 'white' ? 'blancs' : 'noirs');
    final statusText = isYourTurn
        ? 'À vous de jouer'
        : 'En attente du tour de votre adversaire...';

    return Container(
      color: Colors.blueGrey[50],
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(turnText),
          Text(statusText),
        ],
      ),
    );
  }

  Widget _buildGameOverInfo(Game game) {
    bool hasWon = ((game.playerBlack == opponentUsername && game.gameState == 'white_won')||(game.playerWhite == opponentUsername && game.gameState == 'black_won'));
    String txt = hasWon?'Vous avez gagné':'Vous avez perdu';
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        txt,
        style: AppTextStyles.gameHeading
      ),
    );
  }
}
