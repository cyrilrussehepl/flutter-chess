import 'package:flutter/material.dart';
import 'package:projet_chess/services/user_services.dart';
import 'package:projet_chess/widgets/loading.dart';
import 'package:projet_chess/widgets/list_view.dart';

class InvitationsTab extends StatelessWidget {
  final TabController tabController;

  const InvitationsTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final userService = UserService.instance;

    return TabBarView(
      controller: tabController,
      children: <Widget>[
        StreamBuilder(
          stream: userService.getChallengesReceivedStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                    'Une erreur est survenue lors du chargement des défis reçus'),
              );
            }

            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Aucun défi'),
              );
            }

            return ListViewCustom(
                list: snapshot.data!, listType: ListType.invitationsReceived,);
          },
        ),
        StreamBuilder(
          stream: userService.getChallengesSentStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                    'Une erreur est survenue lors du chargement des défis envoyés'),
              );
            }

            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Aucun défi'),
              );
            }

            return ListViewCustom(
              list: snapshot.data!,
              listType: ListType.challengesSent,
            );
          },
        ),
      ],
    );
  }
}
