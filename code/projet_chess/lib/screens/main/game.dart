import 'package:flutter/material.dart';
import 'package:projet_chess/services/games_services.dart';
import 'package:projet_chess/widgets/chess_board.dart';
import 'package:dto/game.dart';

class GameScreen extends StatelessWidget {
  final Game game;
  final GameService _gameService = GameService.instance;

  GameScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partie ${game.playerWhite} vs ${game.playerBlack}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              // Le widget d'échiquier peut être un widget personnalisé
              // que tu as déjà implémenté ou un package externe.
              child: ChessBoard(game: game),
            ),
          ),
          if (game.gameState == 'ongoing')
            if (game.currentTurn == 'white' && game.playerWhite == 'playerId' ||
                game.currentTurn == 'black' && game.playerBlack == 'playerId')
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('C\'est à vous de jouer!'),
                    // Bouton pour effectuer un mouvement
                    ElevatedButton(
                      onPressed: () {
                        // Code pour jouer un coup
                      },
                      child: const Text('Jouer un coup'),
                    ),
                  ],
                ),
              ),
          if (game.gameState != 'ongoing')
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'La partie est terminée: ${game.gameState}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}