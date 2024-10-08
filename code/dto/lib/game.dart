class Game {
  final String gameId;
  final String playerWhite;
  final String playerBlack;
  final String currentTurn; // "white" ou "black"
  final String gameState; // "ongoing", "draw", "white_won", "black_won"
  final List<String> moves;
  final List<String?> boardState;

  Game({
    required this.gameId,
    required this.playerWhite,
    required this.playerBlack,
    required this.currentTurn,
    required this.gameState,
    required this.boardState,
    required this.moves,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameId: json['gameId'],
      playerWhite: json['playerWhite'],
      playerBlack: json['playerBlack'],
      currentTurn: json['currentTurn'],
      gameState: json['gameState'],
      moves: List<String>.from(json['moves']),
      boardState: List<String?>.from(json['boardState']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'playerWhite': playerWhite,
      'playerBlack': playerBlack,
      'currentTurn': currentTurn,
      'gameState': gameState,
      'moves': moves,
      'boardState': boardState,
    };
  }

  @override
  String toString() {
    return 'Game(gameId: $gameId, '
        'playerWhite: $playerWhite, '
        'playerBlack: $playerBlack, '
        'currentTurn: $currentTurn, '
        'gameState: $gameState, '
        'moves: ${moves.join(', ')}, '
        'boardState: ${boardState.join(', ')})';
  }

}
