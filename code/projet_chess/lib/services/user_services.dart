import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/user.dart' as UserDTO;

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserDTO.User> getUser() async {
    final userAuthentifie = _auth.currentUser;

    final userDoc =
        await _firestore.collection('users').doc(userAuthentifie?.email).get();
    UserDTO.User user = UserDTO.User.fromJson(userDoc.data());
    return user;
  }

  Stream<List<String>> getFriendsListStream() {
    final userAuthentifie = _auth.currentUser;
    return _firestore
        .collection('users')
        .doc(userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        UserDTO.User user = UserDTO.User.fromJson(snapshot.data());
        return user.friends;
      } else {
        return [];
      }
    });
  }

  Stream<List<String>> getInvitationsSentStream() {
    final userAuthentifie = _auth.currentUser;
    return _firestore
        .collection('users')
        .doc(userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        UserDTO.User user = UserDTO.User.fromJson(snapshot.data());
        return user.invitationsSent;
      } else {
        return [];
      }
    });
  }

  Stream<List<String>> getInvitationsReceivedStream() {
    final userAuthentifie = _auth.currentUser;
    return _firestore
        .collection('users')
        .doc(userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        UserDTO.User user = UserDTO.User.fromJson(snapshot.data());
        return user.invitationsReceived;
      } else {
        return [];
      }
    });
  }
}
