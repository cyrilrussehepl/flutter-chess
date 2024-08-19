import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:dto/user.dart' as user_dto;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_chess/services/user_services.dart';
import 'package:projet_chess/widgets/loading.dart';

class Profile extends StatefulWidget {
  final String? username;

  const Profile({super.key, this.username});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  final _userServices = UserService.instance;
  bool isInEditMode = false;
  bool isUploading = false;
  final _selectedCountryController = TextEditingController();
  final _selectedFullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildProfileContent(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Profil"),
      actions: widget.username == null
          ? [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isInEditMode = true;
                    });
                  },
                  icon: const Icon(Icons.edit))
            ]
          : [],
      backgroundColor: Colors.blueGrey.withOpacity(0.05),
    );
  }

  Widget _buildProfileContent() {
    return StreamBuilder(
      stream: widget.username == null
          ? _userServices.getUserStream()
          : _userServices.getUserByUsernameStream(widget.username!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Column(
            children: [
              Icon(Icons.error),
              Text('Erreur lors du chargement des données'),
            ],
          );
        }

        user_dto.User user = snapshot.data!;
        _selectedCountryController.text = user.nationality;
        _selectedFullNameController.text = user.fullName;

        return Column(
          children: [
            _buildProfilePicture(user),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Nom d\'utilisateur',
              initialValue: user.username,
              enabled: false,
            ),
            const SizedBox(height: 20),
            _buildEditableTextField(
              controller: _selectedFullNameController,
              label: 'Nom complet',
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Email',
              initialValue: user.email,
              enabled: false,
            ),
            const SizedBox(height: 20),
            _buildCountryPicker(),
            const SizedBox(height: 20),
            if (isInEditMode) _buildEditButtons(),
          ],
        );
      },
    );
  }

  Widget _buildProfilePicture(user_dto.User user) {
    return Stack(
      children: [
        FutureBuilder(
          future: _userServices.getProfilePictureUrl(user.username),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState != ConnectionState.done) {
              return const LoadingWidget();
            } else if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const Icon(Icons.account_circle, size: 100);
            }

            return isUploading
                ? const LoadingWidget()
                : CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        NetworkImage(snapshot.data!) as ImageProvider,
                    backgroundColor: Colors.grey[300],
                  );
          },
        ),
        if (widget.username == null)
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
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required bool enabled,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      enabled: enabled,
    );
  }

  Widget _buildEditableTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      enabled: isInEditMode,
    );
  }

  Widget _buildCountryPicker() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Pays',
        border: OutlineInputBorder(),
      ),
      controller: _selectedCountryController,
      readOnly: true,
      enabled: isInEditMode,
      onTap: () {
        showCountryPicker(
          context: context,
          onSelect: (Country country) {
            _selectedCountryController.text = country.name;
          },
        );
      },
    );
  }

  Widget _buildEditButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: updateUserData,
          icon: const Icon(Icons.check),
          color: Colors.green,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isInEditMode = false;
            });
          },
          icon: const Icon(Icons.close),
          color: Colors.red,
        ),
      ],
    );
  }

  Future<void> showOptions() async {
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

  Future<void> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    updateImage(pickedFile);
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    updateImage(pickedFile);
  }

  Future<void> updateImage(XFile? pickedFile) async {
    setState(() {
      isUploading = true;
    });

    UploadTask uploadTask = await _userServices.updateImage(pickedFile);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      if (snapshot.state != TaskState.running) {
        setState(() {
          isUploading = false;
        });
      }
    });
  }

  void updateUserData() async {
    _userServices.updateUser(
      _selectedFullNameController.text,
      _selectedCountryController.text,
    );
    setState(() {
      isInEditMode = false;
    });
  }
}
