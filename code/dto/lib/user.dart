import 'game_info.dart';

class User {
  String email;
  String username;
  String usernameLowerCase;
  String fullName;
  String nationality;
  List<String> friends;
  List<String> sentFriendRequests;
  List<String> receivedFriendRequests;
  List<String> sentChallengeRequests;
  List<String> receivedChallengeRequests;
  final List<GameInfo> gamesOnGoing;
  final List<GameInfo> gamesOver;

  User({
    required this.email,
    required this.username,
    required this.usernameLowerCase,
    required this.fullName,
    required this.nationality,
    required this.friends,
    required this.sentFriendRequests,
    required this.receivedFriendRequests,
    required this.sentChallengeRequests,
    required this.receivedChallengeRequests,
    required this.gamesOnGoing,
    required this.gamesOver,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      email: json?['email'] as String,
      username: json?['username'] as String,
      usernameLowerCase: json?['usernameLowerCase'] as String,
      fullName: json?['fullName'] as String,
      nationality: json?['nationality'] as String,
      friends: List<String>.from(json?['friends'] as List<dynamic>),
      sentFriendRequests:
          List<String>.from(json?['sentFriendRequests'] as List<dynamic>),
      receivedFriendRequests:
          List<String>.from(json?['receivedFriendRequests'] as List<dynamic>),
      sentChallengeRequests:
          List<String>.from(json?['sentChallengeRequests'] as List<dynamic>),
      receivedChallengeRequests: List<String>.from(
          json?['receivedChallengeRequests'] as List<dynamic>),
      gamesOnGoing: (json?['gamesOnGoing'] as List<dynamic>)
          .map((gameJson) => GameInfo.fromJson(gameJson))
          .toList(),
      gamesOver: (json?['gamesOver'] as List<dynamic>)
          .map((gameJson) => GameInfo.fromJson(gameJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'usernameLowerCase': usernameLowerCase,
      'fullName': fullName,
      'nationality': nationality,
      'friends': friends,
      'sentFriendRequests': sentFriendRequests,
      'receivedFriendRequests': receivedFriendRequests,
      'sentChallengeRequests': sentChallengeRequests,
      'receivedChallengeRequests': receivedChallengeRequests,
      'gamesOnGoing': gamesOnGoing.map((game) => game.toJson()).toList(),
      'gamesOver': gamesOver.map((game) => game.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'User{email: $email, username: $username, friends: $friends, invitationSent: $sentFriendRequests, invitationReceived: $receivedFriendRequests, sentChallengeRequests: $sentChallengeRequests, receivedChallengeRequests: $receivedChallengeRequests}';
  }
}
