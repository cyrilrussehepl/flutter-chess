import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet_chess/services/games_services.dart';
import 'package:projet_chess/services/user_services.dart';
import 'package:dto/user.dart';

List<Widget> friendListActions(String friendId) {
  return <Widget>[
    IconButton(
      icon: Icon(MdiIcons.chessKing),
      onPressed: () async {
        await UserService.instance.sendChallengeRequest(friendId);
      },
    ),
    IconButton(
      icon: const Icon(Icons.person_remove, color: Colors.red),
      onPressed: () async {
        await UserService.instance.removeFriend(friendId);
      },
    ),
  ];
}

List<Widget> invitationListActions(String friendId) {
  return <Widget>[
    IconButton(
      icon: const Icon(Icons.check, color: Colors.green),
      onPressed: () async {
        await UserService.instance.acceptFriendRequest(friendId);
      },
    ),
    IconButton(
      icon: const Icon(Icons.close, color: Colors.red),
      onPressed: () async {
        await UserService.instance.refuseFriendRequest(friendId);
      },
    ),
  ];
}

List<Widget> challengeReceivedActions(String opponentUsername){
  return <Widget>[
    IconButton(
      icon: const Icon(Icons.check, color: Colors.green),
      onPressed: () async {
        User user = await UserService.instance.getUser();
        String newGameId = await GameService.instance.createGame(user.username, opponentUsername);
        await UserService.instance.acceptChallengeRequest(opponentUsername, newGameId);
      },
    ),
    IconButton(
      icon: const Icon(Icons.close, color: Colors.red),
      onPressed: () async {
        await UserService.instance.refuseChallengeRequest(opponentUsername);
      },
    ),
  ];
}

List<Widget> cancelActions(String friendId) {
  return <Widget>[
    IconButton(
      icon: const Icon(Icons.cancel, color: Colors.red),
      onPressed: () async {
        await UserService.instance.cancelChallengeRequest(friendId);
      },
    ),
  ];
}

List<Widget> gameListActions() {
  return <Widget>[
    IconButton(
      icon: const Icon(Icons.play_arrow, color: Colors.blue),
      onPressed: () {
        print('Rejoindre la partie');
      },
    ),
    IconButton(
      icon: const Icon(Icons.info, color: Colors.grey),
      onPressed: () {
        print('Voir les détails de la partie');
      },
    ),
  ];
}
