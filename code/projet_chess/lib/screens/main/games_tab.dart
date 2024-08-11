import 'package:dto/game_info.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/screens/main/game.dart';
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
        listGames(true),
        listGames(false),
      ],
    );
  }

  Widget listGames(bool onGoingGames) {
    final userServices = UserService.instance;
    return StreamBuilder(
        stream: onGoingGames
            ? userServices.getGamesOnGoingStream()
            : userServices.getGamesOverStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                  'Une erreur est survenue lors du chargement des parties'),
            );
          }

          if (snapshot.hasData && snapshot.data!.isEmpty) {
            String txt = onGoingGames ? 'en cours' : 'finie';
            return Center(
              child: Text('Aucune partie $txt'),
            );
          }

          List<GameInfo> games = snapshot.data!;

          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameScreen(gameId: games[index].gameId)));
                    },
                    title: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.green.withOpacity(0.4), width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                        ),
                        child: Text('Partie contre ${games[index].opponent}')),
                  );
                },
              ));
        });
  }
}
