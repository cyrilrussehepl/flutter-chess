import 'package:flutter/material.dart';
import 'package:projet_chess/services/user_services.dart';
import 'package:projet_chess/widgets/loading.dart';
import 'package:projet_chess/widgets/list_view.dart';
import 'package:dto/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_chess/screens/main/profile_tab.dart';

class FriendsTab extends StatefulWidget {
  final TabController tabController;

  @override
  FriendsTabState createState() => FriendsTabState();

  const FriendsTab({super.key, required this.tabController});
}

class FriendsTabState extends State<FriendsTab> {
  List<User> searchResults = [];
  TextEditingController searchController = TextEditingController();
  final _userServices = UserService.instance;
  bool isSending = false;

  Future<List<User>> searchUsers(String query) async {
    if (query.isEmpty) {
      return [];
    }

    final currentUser = await _userServices.getUser();
    String lowercaseQuery = query.toLowerCase();

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('usernameLowerCase', isGreaterThanOrEqualTo: lowercaseQuery)
        .where('usernameLowerCase', isLessThan: lowercaseQuery + 'z')
        .get();

    return snapshot.docs
        .map((doc) {
          User user = User.fromJson(doc.data() as Map<String, dynamic>);
          return user;
        })
        .where((user) =>
            !currentUser.friends.contains(user.username) &&
            !currentUser.sentFriendRequests.contains(user.username) &&
            !currentUser.receivedFriendRequests.contains(user.username))
        .toList();
  }

  @override
  void initState() {
    super.initState();

    searchController.addListener(onSearchChanged);
  }

  void onSearchChanged() async {
    String query = searchController.text;
    List<User> results = await searchUsers(query);
    setState(() {
      searchResults = results;
    });
  }

  void sendFriendRequest(String username) async {
    setState(() {
      isSending = true;
    });
    _userServices.sendFriendRequest(username);
    onSearchChanged();
    setState(() {
      isSending = false;
    });
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userService = UserService.instance;

    return TabBarView(
      controller: widget.tabController,
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
                list: snapshot.data!, listType: ListType.friendsList);
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
              listType: ListType.invitationsReceived,
            );
          },
        ),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: <Widget>[
              SearchBar(
                controller: searchController,
                leading: const Padding(
                    padding: EdgeInsets.all(10), child: Icon(Icons.search)),
                hintText: 'Rechercher un utilisateur...',
              ),
              searchResults.isEmpty
                  ? const Text("")
                  : Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          User user = searchResults[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Profile(username: user.username)));
                            },
                            title: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.green.withOpacity(0.4),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(user.username),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              if (!isSending) {
                                                sendFriendRequest(
                                                    user.username);
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.green,
                                            ))
                                      ],
                                    )
                                  ],
                                )),
                          );
                        },
                      )),
            ]))
      ],
    );
  }
}
