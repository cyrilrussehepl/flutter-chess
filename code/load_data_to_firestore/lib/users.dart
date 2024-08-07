import 'package:dto/user.dart';

List<User> users = [
  User(
      id: 'user1',
      // name: "Ada",
      email: "ada@example.com",
      friends: ['user2', 'user4'],
      sentFriendRequests: [],
      receivedFriendRequests: [],
      sentChallengeRequests: [],
      receivedChallengeRequests:[]
  ),
  User(
      id: 'user2',
      // name: "alan",
      email: "alan@example.com",
      friends: ['user1', 'user3'],
      sentFriendRequests: ['user4', 'user6'],
      receivedFriendRequests: ['user5'],
      sentChallengeRequests: [],
      receivedChallengeRequests:['user3']),
  User(
      id: 'user3',
      // name: "Grace",
      email: "Grace@example.com",
      friends: ['user2'],
      sentFriendRequests: [],
      receivedFriendRequests: ['user4'],
      sentChallengeRequests: ['user2'],
      receivedChallengeRequests:[]),
  User(
      id: 'user4',
      // name: "Linus",
      email: "Linus@example.com",
      friends: ['user1', 'user6'],
      sentFriendRequests: ['user3'],
      receivedFriendRequests: ['user2'],
      sentChallengeRequests: [],
      receivedChallengeRequests:[]),
  User(
      id: 'user5',
      // name: "Margaret",
      email: "Margaret@example.com",
      friends: [],
      sentFriendRequests: ['user2'],
      receivedFriendRequests: ['user6'],
      sentChallengeRequests: [],
      receivedChallengeRequests:[]),
  User(
      id: 'user6',
      // name: "Tim",
      email: "Tim@example.com",
      friends: ['user4'],
      sentFriendRequests: ['user5'],
      receivedFriendRequests: ['user2'],
      sentChallengeRequests: [],
      receivedChallengeRequests:[]),
];
