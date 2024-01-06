import 'package:flutter/material.dart';

class FriendsTab extends StatelessWidget {
  final TabController tabController;

  const FriendsTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const <Widget>[
        Center(child: Text("Liste d'Amis")),
        Center(child: Text("Invitations")),
      ],
    );
  }
}
