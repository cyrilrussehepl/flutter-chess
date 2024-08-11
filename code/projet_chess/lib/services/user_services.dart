import 'package:dto/game_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dto/user.dart' as user_dto;

class UserService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final UserService _instance = UserService._internal();
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  UserService._internal();

  static UserService get instance => _instance;

  Future<user_dto.User> getUser() async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());
    return user;
  }

  Future<String> getProfilePictureUrl(String username) async {
    return await _storage
        .ref('profile_pictures/$username.jpg')
        .getDownloadURL();
  }

  Stream<user_dto.User> getUserStream() {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user;
      } else {
        throw Stream.error('Erreur de chargement des données utilisateur');
      }
    });
  }

  Stream<user_dto.User> getUserByUsernameStream(String username) {
    return _db
        .collection('users')
        .where('username', isEqualTo: username)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        user_dto.User user = user_dto.User.fromJson(snapshot.docs.first.data());
        return user;
      } else {
        throw Stream.error('Erreur de chargement des données utilisateur');
      }
    });
  }

  Stream<String> getUserNationalityStream() {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user.nationality;
      } else {
        throw Stream.error('Erreur de chargement des données utilisateur');
      }
    });
  }

  Stream<List<String>> getFriendsListStream() {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
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
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
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
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
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
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
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
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
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

  Stream<List<GameInfo>> getGamesOnGoingStream() {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user.gamesOnGoing;
      } else {
        return [];
      }
    });
  }

  Stream<List<GameInfo>> getGamesOverStream() {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    return _db
        .collection('users')
        .doc(userAuthentifie?.email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        user_dto.User user = user_dto.User.fromJson(snapshot.data());
        return user.gamesOver;
      } else {
        return [];
      }
    });
  }

  Future<void> removeFriend(String friendId) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('username', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if (querySnapshotFriend.docs.isNotEmpty) {
      friendRef = querySnapshotFriend.docs.first.reference;
    } else {
      throw Future.error('error');
    }

    await userRef.update({
      'friends': FieldValue.arrayRemove([friendId]),
      'receivedChallengeRequests': FieldValue.arrayRemove([friendId]),
      'sentChallengeRequests': FieldValue.arrayRemove([friendId]),
    });

    await friendRef.update({
      'friends': FieldValue.arrayRemove([user.username]),
      'receivedChallengeRequests': FieldValue.arrayRemove([user.username]),
      'sentChallengeRequests': FieldValue.arrayRemove([user.username]),
    });
  }

  Future<void> acceptFriendRequest(String friendId) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('username', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if (querySnapshotFriend.docs.isNotEmpty) {
      friendRef = querySnapshotFriend.docs.first.reference;
    } else {
      throw Future.error('error');
    }

    await userRef.update({
      'friends': FieldValue.arrayUnion([friendId]),
      'receivedFriendRequests': FieldValue.arrayRemove([friendId])
    });

    await friendRef.update({
      'friends': FieldValue.arrayUnion([user.username]),
      'sentFriendRequests': FieldValue.arrayRemove([user.username])
    });
  }

  Future<void> refuseFriendRequest(String friendId) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('username', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if (querySnapshotFriend.docs.isNotEmpty) {
      friendRef = querySnapshotFriend.docs.first.reference;
    } else {
      throw Future.error('error');
    }

    await userRef.update({
      'receivedFriendRequests': FieldValue.arrayRemove([friendId])
    });

    await friendRef.update({
      'sentFriendRequests': FieldValue.arrayRemove([user.username])
    });
  }

  Future<void> sendFriendRequest(String username) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if (querySnapshotFriend.docs.isNotEmpty) {
      friendRef = querySnapshotFriend.docs.first.reference;
    } else {
      throw Future.error('error');
    }

    await userRef.update({
      'sentFriendRequests': FieldValue.arrayUnion([username])
    });

    await friendRef.update({
      'receivedFriendRequests': FieldValue.arrayUnion([user.username])
    });
  }

  Future<void> sendChallengeRequest(String friendId) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('username', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if (querySnapshotFriend.docs.isNotEmpty) {
      friendRef = querySnapshotFriend.docs.first.reference;
    } else {
      throw Future.error('error');
    }

    await userRef.update({
      'sentChallengeRequests': FieldValue.arrayUnion([friendId])
    });

    await friendRef.update({
      'receivedChallengeRequests': FieldValue.arrayUnion([user.username]),
    });
  }

  Future<void> cancelChallengeRequest(String friendId) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('username', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if (querySnapshotFriend.docs.isNotEmpty) {
      friendRef = querySnapshotFriend.docs.first.reference;
    } else {
      throw Future.error('error');
    }

    await userRef.update({
      'sentChallengeRequests': FieldValue.arrayRemove([friendId])
    });

    await friendRef.update({
      'receivedChallengeRequests': FieldValue.arrayRemove([user.username]),
    });
  }

  Future<void> acceptChallengeRequest(String friendId, String gameId) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('username', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if (querySnapshotFriend.docs.isNotEmpty) {
      friendRef = querySnapshotFriend.docs.first.reference;
    } else {
      throw Future.error('error');
    }

    await userRef.update({
      'receivedChallengeRequests': FieldValue.arrayRemove([friendId]),
      'gamesOnGoing':
          FieldValue.arrayUnion([GameInfo(gameId: gameId, opponent: friendId).toJson()])
    });

    await friendRef.update({
      'sentChallengeRequests': FieldValue.arrayRemove([user.username]),
      'gamesOnGoing': FieldValue.arrayUnion(
          [GameInfo(gameId: gameId, opponent: user.username).toJson()])
    });
  }

  Future<void> refuseChallengeRequest(String friendId) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    DocumentReference friendRef;
    final QuerySnapshot querySnapshotFriend = await _db
        .collection('users')
        .where('username', isEqualTo: friendId)
        .limit(1)
        .get();

    final userDoc =
        await _db.collection('users').doc(userAuthentifie?.email).get();
    user_dto.User user = user_dto.User.fromJson(userDoc.data());

    if (querySnapshotFriend.docs.isNotEmpty) {
      friendRef = querySnapshotFriend.docs.first.reference;
    } else {
      throw Future.error('error');
    }

    await userRef.update({
      'receivedChallengeRequests': FieldValue.arrayRemove([friendId])
    });

    await friendRef.update({
      'sentChallengeRequests': FieldValue.arrayRemove([user.username]),
    });
  }

  void updateUser(String newFullName, String newNationality) async {
    final userAuthentifie = FirebaseAuth.instance.currentUser;
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userAuthentifie?.email);
    await userRef
        .update({'fullName': newFullName, 'nationality': newNationality});
  }
}
