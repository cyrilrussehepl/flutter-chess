import 'package:flutter/material.dart';
import 'package:projet_chess/services/user_services.dart';
import 'package:projet_chess/widgets/loading.dart';
import 'package:projet_chess/widgets/list_view.dart';
import 'package:projet_chess/widgets/list_tile_actions.dart';

class FriendsTab extends StatelessWidget {
  final TabController tabController;

  const FriendsTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return TabBarView(
      controller: tabController,
      children: <Widget>[
        StreamBuilder(
          stream: userService.getFriendsListStream(),
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

            return ListViewCustom(
                list: snapshot.data!, actions: friendListActions());
          },
        ),
        StreamBuilder(
          stream: userService.getInvitationsReceivedStream(),
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
                child: Text('Aucune invitation'),
              );
            }

            return ListViewCustom(
              list: snapshot.data!,
              actions: invitationListActions(),
            );
          },
        ),
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
