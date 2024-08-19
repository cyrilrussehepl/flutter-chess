import 'package:dto/game_info.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/screens/game/game.dart';
import 'package:projet_chess/services/user_services.dart';
import 'package:projet_chess/widgets/loading.dart';

class GamesTab extends StatelessWidget {
  final TabController tabController;

  const GamesTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        _buildGamesList(context, true),
        _buildGamesList(context, false),
      ],
    );
  }

  Widget _buildGamesList(BuildContext context, bool onGoingGames) {
    final userServices = UserService.instance;
    return StreamBuilder<List<GameInfo>>(
      stream: onGoingGames
          ? userServices.getGamesOnGoingStream()
          : userServices.getGamesOverStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (snapshot.hasError) {
          return const Center(
            child:
                Text('Une erreur est survenue lors du chargement des parties'),
          );
        }

        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return _buildEmptyState(onGoingGames);
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Aucune donnée disponible'),
          );
        }

        return _buildGamesListView(snapshot.data!);
      },
    );
  }

  Widget _buildEmptyState(bool onGoingGames) {
    String txt = onGoingGames ? 'en cours' : 'finie';
    return Center(
      child: Text('Aucune partie $txt'),
    );
  }

  Widget _buildGamesListView(List<GameInfo> games) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          return _buildGameTile(context, games[index]);
        },
      ),
    );
  }
  //TODO: game over show game state
  Widget _buildGameTile(BuildContext context, GameInfo game) {
    String txt = game.victory == 'ongoing'? '${game.opponent}':'${game.victory.toUpperCase()} vs ${game.opponent}';

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(
              gameId: game.gameId,
              opponentUsername: game.opponent,
            ),
          ),
        );
      },
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green.withOpacity(0.4), width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Text(txt),
      ),
    );
  }
}
