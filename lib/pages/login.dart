// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_e_commerce/pages/forgotPassword.dart';
import 'package:app_e_commerce/pages/home.dart';
import 'package:app_e_commerce/pages/signup.dart';
import 'package:app_e_commerce/provider/googlrSignin.dart';
import 'package:app_e_commerce/shared/constant.dart';
import 'package:app_e_commerce/shared/costum.textField.dart';
import 'package:app_e_commerce/shared/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  //sign in with firebase auth email and password
  signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException {
      showSnackBar(context, "  please check your email or password again ");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      backgroundColor: Scafffold,
      appBar: AppBar(
        backgroundColor: apparAndBottom,
        title: Text(
          "Sign in",
          style: TextStyle(
              color: titleAppbar,
              fontWeight: FontWeight.bold,
              fontFamily: "myfont",
              fontSize: 35),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Email : ",
                        suffixIcon: Icon(
                          Icons.email,
                          color: apparAndBottom,
                        ))),
                const SizedBox(
                  height: 33,
                ),
                TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? false : true,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Password : ",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: isVisable
                                ? Icon(
                                    Icons.visibility,
                                    color: apparAndBottom,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: apparAndBottom,
                                  )))),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await signIn();
                    if (!mounted) return;
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Home()),
                    // );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 34, 25, 86)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "sign in",
                          style: TextStyle(fontSize: 25, color: titleAppbar),
                        ),
                ),
                const SizedBox(
                  height: 33,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()),
                      );
                    },
                    child: Text('Forgot Password?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline))),
                SizedBox(
                  height: 25,
                ),
                Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  direction: Axis.vertical,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have an account?",
                            style: TextStyle(fontSize: 18)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                              );
                            },
                            child: Text('sign up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline))),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
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
                        color: const Color.fromARGB(255, 0, 0, 0),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 260,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 20, 4, 61),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () async {
                      await googleSignInProvider.googlelogin();
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
