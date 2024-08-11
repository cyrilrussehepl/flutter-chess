import 'package:flutter/material.dart';
import 'package:projet_chess/services/games_services.dart';
import 'package:projet_chess/widgets/chess_board.dart';
import 'package:dto/game.dart';
import 'package:projet_chess/widgets/loading.dart';

class GameScreen extends StatelessWidget {
  final String gameId;

  GameScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    final gameService = GameService.instance;
    return
      StreamBuilder(stream: gameService.getGameStream(gameId), builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (snapshot.hasError || (snapshot.hasData && snapshot.data == null)) {
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
              Expanded(
                child: Center(
                  child: ChessBoard(game: game),
                ),
              ),
              if (game.gameState == 'ongoing')
                if (game.currentTurn == 'white' && game.playerWhite == 'janjaTheGoat' ||
                    game.currentTurn == 'black' && game.playerBlack == 'janjaTheGoat')
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
      });


  }
}