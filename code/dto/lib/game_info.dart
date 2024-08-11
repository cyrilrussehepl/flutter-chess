class GameInfo {
  final String gameId;
  final String opponent;

  GameInfo({required this.gameId, required this.opponent});

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'opponent': opponent,
    };
  }

  factory GameInfo.fromJson(Map<String, dynamic> json) {
    return GameInfo(
      gameId: json['gameId'],
      opponent: json['opponent'],
    );
  }
}