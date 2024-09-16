import 'package:app_e_commerce/model/item.dart';
import 'package:app_e_commerce/pages/checkout.dart';
import 'package:app_e_commerce/pages/details.dart';
import 'package:app_e_commerce/pages/login.dart';
import 'package:app_e_commerce/pages/profilePage.dart';
import 'package:app_e_commerce/provider/cart.dart';
import 'package:app_e_commerce/shared/appbar.dart';
import 'package:app_e_commerce/shared/constant.dart';
import 'package:app_e_commerce/shared/drawerData.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);

    return Scaffold(
        backgroundColor: Scafffold,
        body: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 33),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(product: items[index]),
                      ),
                    );
                  },
                  child: GridTile(
                    footer: GridTileBar(
                      trailing: IconButton(
                          color: const Color.fromARGB(255, 62, 94, 70),
                          onPressed: () {
                            carttt.add(items[index]);
                          },
                          icon: const Icon(Icons.add)),
                      leading: Text(
                        ("\$ ${items[index].price.toString()}"),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      title: const Text(
                        "",
                      ),
                    ),
                    child: Stack(children: [
                      Positioned(
                        top: -3,
                        bottom: -9,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.asset(items[index].imgPath)),
                      ),
                    ]),
                  ),
                );
              }),
        ),
        drawer: SafeArea(
          child: Drawer(
            backgroundColor: Scafffold,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    AccountData(),
                    ListTile(
                        title: const Text(
                          "Home",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        leading: const Icon(
                          Icons.home,
                          color: Colors.black,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        }),
                    ListTile(
                        title: const Text(
                          "My products",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        leading: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.black,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Checkout(),
                            ),
                          );
                        }),
                    ListTile(
                        title: const Text(
                          "Profile Page",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        leading: const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        }),
                    ListTile(
                        title: const Text(
                          "Logout",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        leading: const Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                          size: 30,
                        ),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        }),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text("Developed by Ahmed salah © 2024",
                      style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          actions: const [ProductsAndPrice()],
          backgroundColor: apparAndBottom,
          title: const Text(
            "Home",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: titleAppbar,
                fontFamily: "myfont",
                fontSize: 35),
          ),
        ));
  }
}
