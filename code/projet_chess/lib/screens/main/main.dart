import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/screens/main/friends_tab.dart';
import 'package:projet_chess/screens/main/games_tab.dart';
import 'package:projet_chess/screens/main/profile_tab.dart';
import 'package:projet_chess/widgets/logout_button.dart';
import 'package:dto/user.dart' as userDTO;
import 'package:projet_chess/widgets/loading.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabControllerForParties;
  late TabController _tabControllerForFriends;
  late final Stream<DocumentSnapshot<userDTO.User>>? _userStream;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isSessionInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabControllerForParties = TabController(vsync: this, length: 2);
    _tabControllerForFriends = TabController(vsync: this, length: 3);

    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final User? user = firebaseAuth.currentUser;

    if (user != null) {
      setState(() {
        isSessionInitialized = true;
      });
    } else {
      firebaseAuth.authStateChanges().listen((User? user) {
        if (mounted) {
          setState(() {
            isSessionInitialized = user != null;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _tabControllerForParties.dispose();
    _tabControllerForFriends.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChessPointCom'),
        actions: <Widget>[
          LogoutButton(),
        ],
        bottom: _selectedIndex == 0 || _selectedIndex == 1
            ? (_selectedIndex == 0
                ? TabBar(
                    controller: _tabControllerForParties,
                    tabs: const [
                      Tab(text: 'En cours'),
                      Tab(text: 'Finies'),
                    ],
                  )
                : TabBar(
                    controller: _tabControllerForFriends,
                    tabs: const [
                      Tab(text: 'Amis'),
                      Tab(text: 'Invitations'),
                      Tab(icon: Icon(Icons.add))
                    ],
                  ))
            : null,
      ),
      body: !isSessionInitialized ? const LoadingWidget() : _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Parties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Amis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return GamesTab(tabController: _tabControllerForParties);
      case 1:
        return FriendsTab(tabController: _tabControllerForFriends);
      case 2:
        return const Profile();
      default:
        return const Center(child: Text("Erreur"));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
