import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dto/user.dart' as user_dto;
import 'user_services.dart';

class GameService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final GameService _instance = GameService._internal();
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static String? username;

  GameService._internal();

  static GameService get instance => _instance;

  void refreshUsername() async {
    final user = await UserService.instance.getUser();
    username = user.username;
  }



  }