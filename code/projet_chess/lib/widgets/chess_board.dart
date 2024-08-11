import 'package:flutter/material.dart';
import 'package:dto/game.dart';

class ChessBoard extends StatelessWidget {
  final Game game;

  const ChessBoard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    // Logique pour afficher le plateau d'échecs
    return Container(
      color: Colors.grey,
      child: Center(
        child: Text('Échiquier (implémentation à venir)'),
      ),
    );
  }
}