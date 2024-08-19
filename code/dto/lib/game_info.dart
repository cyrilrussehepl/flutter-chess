class GameInfo {
  final String gameId;
  final String opponent;
  final String victory;// victory, defeat, ongoing


  GameInfo({required this.gameId, required this.opponent, required this.victory});

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'opponent': opponent,
      'victory': victory
    };
  }

  factory GameInfo.fromJson(Map<String, dynamic> json) {
    return GameInfo(
      gameId: json['gameId'],
      opponent: json['opponent'],
      victory: json['victory'],
    );
  }
}