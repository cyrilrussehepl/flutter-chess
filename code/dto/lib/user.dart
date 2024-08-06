class User {
  String email;
  String id;
  List<String> friends;
  List<String> invitationsSent;
  List<String> invitationsReceived;

  User({
    required this.email,
    required this.id,
    required this.friends,
    required this.invitationsSent,
    required this.invitationsReceived,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      email: json?['email'] as String ?? '',
      id: json?['id'] as String ?? '',
      friends: List<String>.from(json?['friends'] as List<dynamic>) ?? [],
      invitationsSent:
          List<String>.from(json?['invitationsSent'] as List<dynamic>) ?? [],
      invitationsReceived:
          List<String>.from(json?['invitationsReceived'] as List<dynamic>) ??
              [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'friends': friends,
      'invitationsSent': invitationsSent,
      'invitationsReceived': invitationsReceived,
    };
  }

  @override
  String toString() {
    return 'User{email: $email, id: $id, friends: $friends, invitationSent: $invitationsSent, invitationReceived: $invitationsReceived}';
  }
}
