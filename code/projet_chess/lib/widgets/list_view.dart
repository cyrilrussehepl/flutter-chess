import 'package:flutter/material.dart';
import 'package:projet_chess/screens/main/profile_tab.dart';
import 'package:projet_chess/widgets/list_tile_actions.dart';

enum ListType {
  friendsList,
  invitationsReceived,
  invitationsSent,
  challengesSent
}

class ListViewCustom extends StatelessWidget {
  final List<String> list;
  final ListType listType;

  const ListViewCustom({super.key, required this.list, required this.listType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              if (listType == ListType.friendsList || listType == ListType.invitationsReceived || listType == ListType.invitationsSent || listType == ListType.challengesSent ) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(username: list[index])));
              }
            },
            title: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.green.withOpacity(0.4), width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(list[index]),
                    Row(children: tileActions(listType, list[index]))
                  ],
                )),
          );
        },
      ),
    ));
  }

  List<Widget> tileActions(ListType listType, String item) {
    switch (listType) {
      case ListType.friendsList:
        return friendListActions(item);
      case ListType.challengesSent:
        return cancelActions(item);
      case ListType.invitationsReceived:
        return invitationListActions(item);
      default:
        return [];
    }
  }
}
