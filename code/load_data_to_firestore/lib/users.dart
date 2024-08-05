import 'package:dto/user.dart';

const List<User> users = [
  User(
    id:'user1',
    // name: "Ada",
    email: "ada@example.com",
    friends: ['user2', 'user4'],
    invitationsSent:[],
    invitationsReceived:[]
  ),
  User(
    id:'user2',
    // name: "alan",
    email: "alan@example.com",
    friends: ['user1', 'user3'],
    invitationsSent:['user4', 'user6'],
    invitationsReceived:['user5']
  ),
  User(
    id:'user3',
    // name: "Grace",
    email: "Grace@example.com",
    friends: ['user2'],
    invitationsSent:[],
    invitationsReceived:['user4']
  ),
  User(
    id:'user4',
    // name: "Linus",
    email: "Linus@example.com",
    friends: ['user1', 'user6'],
    invitationsSent:['user3'],
    invitationsReceived:['user2']
  ),
  User(
    id:'user5',
    // name: "Margaret",
    email: "Margaret@example.com",
    friends: [],
    invitationsSent:['user2'],
    invitationsReceived:['user6']
  ),
  User(
    id:'user6',
    // name: "Tim",
    email: "Tim@example.com",
    friends: ['user4'],
    invitationsSent:['user5'],
    invitationsReceived:['user2']
  ),
];
