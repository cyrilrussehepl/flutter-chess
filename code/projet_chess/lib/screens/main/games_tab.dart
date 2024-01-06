import 'package:flutter/material.dart';

class GamesTab extends StatelessWidget {
  final TabController tabController;

  const GamesTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const <Widget>[
        Center(child: Text("Parties en Cours")),
        Center(child: Text("Parties Finies")),
      ],
    );
  }
}
