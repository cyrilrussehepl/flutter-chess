import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:dto/user.dart' as user_dto;
import 'package:projet_chess/services/user_services.dart';
import 'package:projet_chess/widgets/loading.dart';
import 'dart:async';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  final _userServices = UserService.instance;
  final _storage = FirebaseStorage.instance;
  bool isUploading = false;

  Future getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    updateImage(pickedFile);
  }

  Future getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    updateImage(pickedFile);
  }

  void updateImage(XFile? pickedFile) async {
    setState(() {
      isUploading = true;
    });
    user_dto.User user = await _userServices.getUser();
    final uploadTask = _storage
        .ref()
        .child('profile_pictures/${user.username}.jpg')
        .putFile(File(pickedFile!.path));

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      if (snapshot.state != TaskState.running) {
        setState(() {
          isUploading = false;
        });
      }
    });
  }

  showOptions() async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
            stream: _userServices.getUserStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Column(children: [
                  Icon(Icons.error),
                  Text('Erreur lors du chargement des données')
                ]);
              }

              user_dto.User user = snapshot.data!;

              return Column(
                children: [
                  Stack(
                    children: [
                      FutureBuilder(
                          future: _userServices.getProfilePictureUrl(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.connectionState !=
                                    ConnectionState.done) {
                              return const LoadingWidget();
                            } else if (snapshot.hasError ||
                                !snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Icon(Icons.account_circle,
                                  size: 100);
                            }

                            return isUploading
                                ? const LoadingWidget()
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage(snapshot.data!)
                                            as ImageProvider,
                                    backgroundColor: Colors.grey[300],
                                  );
                          }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: isUploading ? null : showOptions,
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: user.username,
                    decoration: const InputDecoration(
                      labelText: 'Nom d\'utilisateur',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: user.fullName,
                    decoration: const InputDecoration(
                      labelText: 'Nom complet',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: user.email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: user.nationality,
                    decoration: const InputDecoration(
                      labelText: 'Nationalité',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                    style: const TextStyle(color: Colors.blueGrey),
                  )
                ],
              );
            }));
  }
}
