import 'package:dto/user.dart';
import 'package:dto/game_info.dart';

List<User> users = [
  User(
      username: 'adam',
      usernameLowerCase: 'adam',
      fullName: "Adam Ondra",
      nationality: "",
      email: "Adam@example.com",
      friends: [
        'janjaTheGoat',
        'LightningBolt'
      ],
      sentFriendRequests: [],
      receivedFriendRequests: [],
      sentChallengeRequests: [],
      receivedChallengeRequests: [],
      gamesOnGoing: [
        GameInfo(gameId: 'game1', opponent: 'janjaTheGoat'),
      ],
      gamesOver: []),
  User(
      username: 'janjaTheGoat',
      usernameLowerCase: 'janjathegoat',
      fullName: "Janja Garnbret",
      nationality: "Czech Republic",
      email: "Janja@example.com",
      friends: [
        'adam',
        'antoine'
      ],
      sentFriendRequests: [
        'LightningBolt',
        'CabeiBusha'
      ],
      receivedFriendRequests: [
        'MM'
      ],
      sentChallengeRequests: [],
      receivedChallengeRequests: [
        'antoine'
      ],
      gamesOnGoing: [
        GameInfo(gameId: 'game1', opponent: 'adam'),
      ],
      gamesOver: []),
  User(
      username: 'antoine',
      usernameLowerCase: 'antoine',
      fullName: "Antoine Albeau",
      nationality: "",
      email: "Antoine@example.com",
      friends: [
        'janjaTheGoat'
      ],
      sentFriendRequests: [],
      receivedFriendRequests: [
        'LightningBolt'
      ],
      sentChallengeRequests: [
        'janjaTheGoat'
      ],
      receivedChallengeRequests: [],
      gamesOnGoing: [
        GameInfo(gameId: 'game2', opponent: 'LightningBolt'),
      ],
      gamesOver: []),
  User(
      username: 'LightningBolt',
      usernameLowerCase: 'lightningbolt',
      fullName: "Usain Bolt",
      nationality: "",
      email: "Usain@example.com",
      friends: [
        'adam',
        'CabeiBusha'
      ],
      sentFriendRequests: [
        'antoine'
      ],
      receivedFriendRequests: [
        'janjaTheGoat'
      ],
      sentChallengeRequests: [],
      receivedChallengeRequests: [],
      gamesOnGoing: [
        GameInfo(gameId: 'game2', opponent: 'antoine'),
      ],
      gamesOver: []),
  User(
      username: 'MM',
      usernameLowerCase: 'mm',
      fullName: "Magnus Mitbø",
      nationality: "",
      email: "Magnus@example.com",
      friends: [],
      sentFriendRequests: [
        'janjaTheGoat'
      ],
      receivedFriendRequests: [
        'CabeiBusha'
      ],
      sentChallengeRequests: [],
      receivedChallengeRequests: [],
      gamesOnGoing: [
        GameInfo(gameId: 'game3', opponent: 'CabeiBusha'),
      ],
      gamesOver: []),
  User(
      username: 'CabeiBusha',
      usernameLowerCase: 'cabeibusha',
      fullName: "Sarah-Quita Offringa",
      nationality: "",
      email: "SarahQuita@example.com",
      friends: [
        'LightningBolt'
      ],
      sentFriendRequests: [
        'MM'
      ],
      receivedFriendRequests: [
        'janjaTheGoat'
      ],
      sentChallengeRequests: [],
      receivedChallengeRequests: [],
      gamesOnGoing: [
        GameInfo(gameId: 'game3', opponent: 'MM'),
      ],
      gamesOver: []),
];
