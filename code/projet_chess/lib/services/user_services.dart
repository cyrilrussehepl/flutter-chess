import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/user.dart' as UserDTO;

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserDTO.User> getUser() async{
    final userAuthentifie = _auth.currentUser;

    final userDoc = await _firestore.collection('users').doc(userAuthentifie?.email).get();
    UserDTO.User user = UserDTO.User.fromJson(userDoc.data());
    return user;
  }

  Future<List<String>> getFriendsList() async {
    try {
      UserDTO.User user = await getUser();
      return user.friends;
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getInvitationsSent() async {
    try {
      UserDTO.User user = await getUser();
      return user.invitationsSent;
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getInvitationsReceived() async {
    try {
      UserDTO.User user = await getUser();
      return user.invitationsReceived;
    } catch (e) {
      return [];
    }
  }
}

