// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:app_e_commerce/pages/login.dart';
import 'package:app_e_commerce/pages/welcome.dart';
import 'package:app_e_commerce/shared/constant.dart';
import 'package:app_e_commerce/shared/getDataFirestore.dart';
import 'package:app_e_commerce/shared/getImage.dart';
import 'package:app_e_commerce/shared/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show basename;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
  //instance froom document in firstore database
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  File? imgPath;
  //function to add photo to app
  uploadImage(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {}
    } catch (e) {
      showSnackBar(context, ("no photo selected"));
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  String? imgName;
  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Scafffold,
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: apparAndBottom,
        title: Text(
          "MY Profile",
          style: TextStyle(
              color: titleAppbar,
              fontWeight: FontWeight.bold,
              fontFamily: "myfont",
              fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 197, 197, 235)),
                child: Stack(
                  children: [
                    imgPath == null
                        ? ImgUser()
                        : ClipOval(
                            child: Image.file(
                              imgPath!,
                              width: 145,
                              height: 145,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned(
                        bottom: 0,
                        left: 107,
                        child: IconButton(
                          onPressed: () async {
                            await showmodel();
                            if (imgPath != null) {
                              // Upload image to firebase storage
                              final storageRef =
                                  FirebaseStorage.instance.ref("imgName");
                              await storageRef.putFile(imgPath!);
                              // Get img url
                              String urlll = await storageRef.getDownloadURL();

                              users.doc(credential!.uid).update({
                                "imgLink": urlll,
                              });
                            }
                          },
                          icon: Icon(Icons.add_a_photo),
                          color: const Color.fromARGB(255, 48, 40, 40),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: apparAndBottom,
                    borderRadius: BorderRadius.circular(11)),
                child: Text(
                  "Info from firebase Auth",
                  style: TextStyle(
                      fontSize: 22, color: titleAppbar, fontFamily: "myfont"),
                ),
              )),
              SizedBox(
                height: 22,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Email:  ${credential!.email}     ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Created date: ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}      ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Last Signed In: ${DateFormat("MMMM d, y").format(credential!.metadata.lastSignInTime!)}  ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: TextButton(
                    onPressed: () {
                      setState(() {
                        credential!.delete();
                        users.doc(credential!.uid).delete();
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Welcome()),
                        );
                      });
                    },
                    child: Text("Delete User",
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        )),
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: apparAndBottom,
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        "Info from firebase firestore",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "myfont",
                            color: titleAppbar),
                      ))),
              SizedBox(
                height: 22,
              ),
              Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                direction: Axis.vertical,
                children: [
                  GetDataFromFirestore(
                    documentId: credential!.uid,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
