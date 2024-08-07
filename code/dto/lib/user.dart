class User {
  String email;
  String id;
  List<String> friends;
  List<String> sentFriendRequests;
  List<String> receivedFriendRequests;
  List<String> sentChallengeRequests;
  List<String> receivedChallengeRequests;

  User({
    required this.email,
    required this.id,
    required this.friends,
    required this.sentFriendRequests,
    required this.receivedFriendRequests,
    required this.sentChallengeRequests,
    required this.receivedChallengeRequests,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      email: json?['email'] as String ?? '',
      id: json?['id'] as String ?? '',
      friends: List<String>.from(json?['friends'] as List<dynamic>) ?? [],
      sentFriendRequests:
          List<String>.from(json?['sentFriendRequests'] as List<dynamic>) ?? [],
      receivedFriendRequests:
          List<String>.from(json?['receivedFriendRequests'] as List<dynamic>) ??
              [],
      sentChallengeRequests:
          List<String>.from(json?['challengesSent'] as List<dynamic>) ??
              [],
      receivedChallengeRequests:
          List<String>.from(json?['challengesReceived'] as List<dynamic>) ??
              [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'friends': friends,
      'sentFriendRequests': sentFriendRequests,
      'receivedFriendRequests': receivedFriendRequests,
      'challengesSent':sentChallengeRequests,
      'challengesReceived':receivedChallengeRequests,
    };
  }

  @override
  String toString() {
    return 'User{email: $email, id: $id, friends: $friends, invitationSent: $sentFriendRequests, invitationReceived: $receivedFriendRequests, challengesSent: $sentChallengeRequests, challengesReceived: $receivedChallengeRequests}';
  }
}
