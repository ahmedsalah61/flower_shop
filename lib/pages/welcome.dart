import 'package:app_e_commerce/pages/login.dart';
import 'package:app_e_commerce/pages/signup.dart';
import 'package:app_e_commerce/provider/googlrSignin.dart';
import 'package:app_e_commerce/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Scafffold,
            body: SingleChildScrollView(
                child: Column(children: [
              const Padding(padding: EdgeInsets.all(20)),
              Center(
                child: Image.asset(
                  "assets/img/welcome.png",
                  height: 300,
                ),
              ),
              const Text(
                "welcome to flower shop",
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: "myfont",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 34, 25, 86)),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 13)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                ),
                child: const Text(
                  "login",
                  style: TextStyle(fontSize: 22, color: titleAppbar),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 226, 217, 220)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 95, vertical: 13)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                ),
                child: const Text(
                  "SIGNUP",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              const SizedBox(
                width: 299,
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.6,
                      color: Colors.black,
                    )),
                    Text(
                      "OR",
                      style: TextStyle(),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.6,
                      color: Colors.black,
                    )),
                  ],
                ),
              ),
              Container(
                width: 260,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 20, 4, 61),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    googleSignInProvider.googlelogin();
                  },
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    direction: Axis.vertical,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            padding: const EdgeInsets.only(right: 30),
                            child: SvgPicture.asset(
                              "assets/icons/google.svg",
                              height: 60,
                            ),
                          ),
                          Text(
                            "Log in with Google",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: titleAppbar),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]))));
  }
}
