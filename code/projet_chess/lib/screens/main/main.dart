import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_chess/screens/main/friends_tab.dart';
import 'package:projet_chess/screens/main/games_tab.dart';
import 'package:projet_chess/screens/main/invitations_tab.dart';
import 'package:projet_chess/screens/main/profile_tab.dart';
import 'package:projet_chess/widgets/loading.dart';
import 'package:projet_chess/widgets/logout_button.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main';

  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabControllerForParties;
  late TabController _tabControllerForFriends;
  late TabController _tabControllerForInvitations;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isSessionInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabControllerForParties = TabController(vsync: this, length: 2);
    _tabControllerForFriends = TabController(vsync: this, length: 3);
    _tabControllerForInvitations = TabController(vsync: this, length: 2);

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

  TabBar _buildTabBar() {
    if (_selectedIndex == 0) {
      return TabBar(
        controller: _tabControllerForParties,
        tabs: const [
          Tab(text: 'En cours'),
          Tab(text: 'Finies'),
        ],
      );
    } else if (_selectedIndex == 1) {
      return TabBar(
        controller: _tabControllerForFriends,
        tabs: const [
          Tab(text: 'Amis'),
          Tab(text: 'Invitations'),
          Tab(icon: Icon(Icons.add)),
        ],
      );
    } else {
      return TabBar(
        controller: _tabControllerForInvitations,
        tabs: const [
          Tab(text: 'Défis reçus'),
          Tab(text: 'Défis en attente'),
        ],
      );
    }
  }

  @override
  void dispose() {
    _tabControllerForParties.dispose();
    _tabControllerForFriends.dispose();
    _tabControllerForInvitations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncChess'),
        actions: <Widget>[
          LogoutButton(),
        ],
        bottom: _selectedIndex == 0 || _selectedIndex == 1 || _selectedIndex == 2
            ? _buildTabBar()
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
          BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Défis'),
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
        return InvitationsTab(tabController: _tabControllerForInvitations);
      case 3:
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
