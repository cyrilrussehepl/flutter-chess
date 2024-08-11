import 'package:flutter/material.dart';
import 'package:projet_chess/services/games_services.dart';

class GamesTab extends StatelessWidget {
  final TabController tabController;
  final _gameServices = GameService.instance;

  GamesTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const <Widget>[
        Center(child: Text("Parties en Cours")),
        Center(child: Text("Parties Finies")),
      ],
    );
  }
}
