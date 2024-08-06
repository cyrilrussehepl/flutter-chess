import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<Widget> friendListActions() {
  return <Widget>[
    IconButton(
      icon: Icon(MdiIcons.chessKing),
      onPressed: () {
        print('Défier à une partie');
      },
    ),
    IconButton(
      icon: Icon(Icons.person_remove, color: Colors.red),
      onPressed: () {
        print('Supprimer');
      },
    ),
  ];
}

List<Widget> invitationListActions() {
  return <Widget>[
    IconButton(
      icon: Icon(Icons.check, color: Colors.green),
      onPressed: () {
        print('Accepter l\'invitation');
      },
    ),
    IconButton(
      icon: Icon(Icons.close, color: Colors.red),
      onPressed: () {
        print('Rejeter l\'invitation');
      },
    ),
  ];
}

List<Widget> gameListActions() {
  return <Widget>[
    IconButton(
      icon: Icon(Icons.play_arrow, color: Colors.blue),
      onPressed: () {
        print('Rejoindre la partie');
      },
    ),
    IconButton(
      icon: Icon(Icons.info, color: Colors.grey),
      onPressed: () {
        print('Voir les détails de la partie');
      },
    ),
  ];
}
