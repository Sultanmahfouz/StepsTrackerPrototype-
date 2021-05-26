import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/screens/landing.dart';
import 'package:steps_tracker_prototype/services/user.dart';
import 'authentication/components/button.dart';

class GetInfo extends StatefulWidget {
  @override
  _GetInfoState createState() => _GetInfoState();
}

class _GetInfoState extends State<GetInfo> {
  String name;
  String imageUrl;
  File _imageFile;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Colors.white,
          title: Text(
            'Validation',
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please choose a valid name'),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                height: 25,
                width: 70,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Noted',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> updateUserAvatar(File imageFile) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('user-image');

    StorageUploadTask uploadTask = ref.putFile(imageFile);

    final String photoUrl =
        await (await uploadTask.onComplete).ref.getDownloadURL();

    return photoUrl;
  }

  Future<void> pickImage(ImageSource source) async {
    File selectedImage =
        // ignore: deprecated_member_use
        await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = selectedImage;
    });

    if (_imageFile != null) {
      var photoUrl = await updateUserAvatar(_imageFile);
      if (mounted) {
        // to check if the widget is in the tree
        setState(() {
          imageUrl = photoUrl;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: decorationLayout,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100, left: 25),
                child: Text(
                  'Profile',
                  style: textHeaderStyle,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: imageUrl == null
                                ? AssetImage('assets/images/anonymous.png')
                                : NetworkImage(imageUrl),
                          ),
                          Positioned(
                            bottom: 3,
                            right: 5,
                            child: InkWell(
                              onTap: () {
                                pickImage(ImageSource.gallery);
                              },
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: primaryColor,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 10),
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter a valid name' : null,
                        style: TextStyle(color: primaryColor),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration: fieldDecoration.copyWith(
                          prefixIcon: Icon(
                            Icons.person,
                            color: primaryColor,
                          ),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    Text(
                      '* image is not required',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Center(
                child: AuthButton(
                  onPressed: () {
                    if (name != null) {
                      UserService(
                        uid: FirebaseAuth.instance.currentUser.uid,
                        name: name,
                        avatar: imageUrl == null ? '' : imageUrl,
                      ).updateUserData();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => Landing()));
                    } else {
                      _showMyDialog();
                    }
                  },
                  title: 'START',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
