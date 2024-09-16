// ignore_for_file: prefer_const_constructors

import 'package:app_e_commerce/shared/getImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountData extends StatefulWidget {
  const AccountData({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountData> createState() => _AccountDataState();
}

class _AccountDataState extends State<AccountData> {
  final credential = FirebaseAuth.instance.currentUser!;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(credential.photoURL!), fit: BoxFit.cover),
            ),
            currentAccountPicture: CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(credential.photoURL!)),
            accountEmail: Text(credential.email!),
            accountName: Text(credential.displayName!,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          // ${data['title']}
          return UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("${data["imgLink"]}"), fit: BoxFit.cover),
            ),
            currentAccountPicture: ImgUser(),
            accountEmail: Text("${data["email"]}"),
            accountName: Text("${data["username"]}",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
          );
        }

        return Text("loading");
      },
    );
  }
}
