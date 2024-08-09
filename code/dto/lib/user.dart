class User {
  String email;
  String username;
  String fullName;
  String nationality;
  String profilePicture;
  List<String> friends;
  List<String> sentFriendRequests;
  List<String> receivedFriendRequests;
  List<String> sentChallengeRequests;
  List<String> receivedChallengeRequests;


  User({
    required this.email,
    required this.username,
    required this.fullName,
    required this.nationality,
    required this.profilePicture,
    required this.friends,
    required this.sentFriendRequests,
    required this.receivedFriendRequests,
    required this.sentChallengeRequests,
    required this.receivedChallengeRequests,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      email: json?['email'] as String ?? '',
      username: json?['username'] as String ?? '',
      fullName: json?['fullName'] as String ?? '',
      nationality: json?['nationality'] as String ?? '',
      profilePicture: json?['profilePicture'] as String ?? '',
      friends: List<String>.from(json?['friends'] as List<dynamic>) ?? [],
      sentFriendRequests:
          List<String>.from(json?['sentFriendRequests'] as List<dynamic>) ?? [],
      receivedFriendRequests:
          List<String>.from(json?['receivedFriendRequests'] as List<dynamic>) ??
              [],
      sentChallengeRequests:
          List<String>.from(json?['sentChallengeRequests'] as List<dynamic>) ??
              [],
      receivedChallengeRequests:
          List<String>.from(json?['receivedChallengeRequests'] as List<dynamic>) ??
              [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'fullName': fullName,
      'nationality': nationality,
      'profilePicture': profilePicture,
      'friends': friends,
      'sentFriendRequests': sentFriendRequests,
      'receivedFriendRequests': receivedFriendRequests,
      'sentChallengeRequests':sentChallengeRequests,
      'receivedChallengeRequests':receivedChallengeRequests,
    };
  }

  @override
  String toString() {
    return 'User{email: $email, username: $username, friends: $friends, invitationSent: $sentFriendRequests, invitationReceived: $receivedFriendRequests, sentChallengeRequests: $sentChallengeRequests, receivedChallengeRequests: $receivedChallengeRequests}';
  }
}
