import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/user.dart' as user_dto;

class UserService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final _userAuthentifie = FirebaseAuth.instance.currentUser;
  static final UserService _instance = UserService._internal();

  UserService._internal();

  static UserService get instance => _instance;

  Future<user_dto.User> getUser() async {
    final userDoc =
        await _db.collection('users').doc(_userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());
    return user;
  }

  Stream<List<String>> getFriendsListStream() {
    return _db
        .collection('users')
        .doc(_userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user.friends;
      } else {
        return [];
      }
    });
  }

  Stream<List<String>> getInvitationsSentStream() {
    return _db
        .collection('users')
        .doc(_userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user.sentFriendRequests;
      } else {
        return [];
      }
    });
  }

  Stream<List<String>> getInvitationsReceivedStream() {
    return _db
        .collection('users')
        .doc(_userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user.receivedFriendRequests;
      } else {
        return [];
      }
    });
  }

  Stream<List<String>> getChallengesSentStream() {
    return _db
        .collection('users')
        .doc(_userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user.sentChallengeRequests;
      } else {
        return [];
      }
    });
  }

  Stream<List<String>> getChallengesReceivedStream() {
    return _db
        .collection('users')
        .doc(_userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user.receivedChallengeRequests;
      } else {
        return [];
      }
    });
  }

  Future<void> removeFriend(String friendId) async {
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(_userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('id', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
    await _db.collection('users').doc(_userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if(querySnapshotFriend.docs.isNotEmpty){
      friendRef = querySnapshotFriend.docs.first.reference;
    }
    else {
      throw Future.error('error');
    }

    await userRef.update({
      'friends': FieldValue.arrayRemove([friendId]),
      'receivedChallengeRequests': FieldValue.arrayRemove([friendId]),
      'sentChallengeRequests': FieldValue.arrayRemove([friendId]),
    });

    await friendRef.update({
      'friends': FieldValue.arrayRemove([user.id]),
      'receivedChallengeRequests': FieldValue.arrayRemove([user.id]),
      'sentChallengeRequests': FieldValue.arrayRemove([user.id]),
    });
  }

  Future<void> acceptFriendRequest(String friendId) async {
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(_userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('id', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
    await _db.collection('users').doc(_userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if(querySnapshotFriend.docs.isNotEmpty){
      friendRef = querySnapshotFriend.docs.first.reference;
    }
    else {
      throw Future.error('error');
    }

    await userRef.update({
      'friends': FieldValue.arrayUnion([friendId]),
      'receivedFriendRequests': FieldValue.arrayRemove([friendId])
    });

    await friendRef.update({
      'friends': FieldValue.arrayUnion([user.id]),
      'sentFriendRequests': FieldValue.arrayRemove([user.id])
    });
  }

  Future<void> refuseFriendRequest(String friendId) async {
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(_userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('id', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
    await _db.collection('users').doc(_userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if(querySnapshotFriend.docs.isNotEmpty){
      friendRef = querySnapshotFriend.docs.first.reference;
    }
    else {
      throw Future.error('error');
    }

    await userRef.update({
      'receivedFriendRequests': FieldValue.arrayRemove([friendId])
    });

    await friendRef.update({
      'sentFriendRequests': FieldValue.arrayRemove([user.id])
    });
  }

  Future<void> sendChallengeRequest(String friendId) async {
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(_userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('id', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
    await _db.collection('users').doc(_userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if(querySnapshotFriend.docs.isNotEmpty){
      friendRef = querySnapshotFriend.docs.first.reference;
    }
    else {
      throw Future.error('error');
    }

    await userRef.update({
      'sentChallengeRequests': FieldValue.arrayUnion([friendId])
    });

    await friendRef.update({
      'receivedChallengeRequests': FieldValue.arrayUnion([user.id]),
    });
  }

  Future<void> cancelChallengeRequest(String friendId) async {
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(_userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('id', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
    await _db.collection('users').doc(_userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if(querySnapshotFriend.docs.isNotEmpty){
      friendRef = querySnapshotFriend.docs.first.reference;
    }
    else {
      throw Future.error('error');
    }

    await userRef.update({
      'sentChallengeRequests': FieldValue.arrayRemove([friendId])
    });

    await friendRef.update({
      'receivedChallengeRequests': FieldValue.arrayRemove([user.id]),
    });
  }

  Future<void> refuseChallengeRequest(String friendId) async {
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(_userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('id', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
    await _db.collection('users').doc(_userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if(querySnapshotFriend.docs.isNotEmpty){
      friendRef = querySnapshotFriend.docs.first.reference;
    }
    else {
      throw Future.error('error');
    }

    await userRef.update({
      'receivedChallengeRequests': FieldValue.arrayRemove([friendId])
    });

    await friendRef.update({
      'sentChallengeRequests': FieldValue.arrayRemove([user.id]),
    });
  }

}
