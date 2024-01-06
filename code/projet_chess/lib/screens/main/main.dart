import 'package:flutter/material.dart';
import 'package:projet_chess/screens/main/friends_tab.dart';
import 'package:projet_chess/screens/main/games_tab.dart';
import 'package:projet_chess/screens/main/profile.dart';
import 'package:projet_chess/widgets/logout_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabControllerForParties;
  late TabController _tabControllerForFriends;

  @override
  void initState() {
    super.initState();
    _tabControllerForParties = TabController(vsync: this, length: 2);
    _tabControllerForFriends = TabController(vsync: this, length: 2);
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
        actions: const <Widget>[
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
                    ],
                  ))
            : null,
      ),
      drawer: const Drawer(
          ),
      body: _buildBody(),
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
