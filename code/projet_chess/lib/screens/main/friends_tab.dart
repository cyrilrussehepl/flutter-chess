import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:projet_chess/services/user_services.dart';
import 'package:projet_chess/widgets/loading.dart';
import 'package:projet_chess/widgets/list_view.dart';

class FriendsTab extends StatelessWidget {
  final TabController tabController;

  const FriendsTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return TabBarView(
      controller: tabController,
      children: <Widget>[
        FutureBuilder<List<String>>(
            future: userService.getFriendsList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                      'Une erreur est survenue lors du chargement de la liste d\'amis'),
                );
              }

              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Vous n\'avez pas encore d\'amis'),
                );
              }

              return ListViewCustom(list: snapshot.data!);
            }),
        FutureBuilder<List<String>>(
            future: userService.getInvitationsReceived(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                      'Une erreur est survenue lors du chargement des demandes d\'amis'),
                );
              }

              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Aucune invitations'),
                );
              }

              return ListViewCustom(list: snapshot.data!);
            }),
        const Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              SearchBar(
                leading: Padding(
                    padding: EdgeInsets.all(10), child: Icon(Icons.search)),
              )
            ]))
      ],
    );
  }
}
