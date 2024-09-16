import 'package:app_e_commerce/pages/login.dart';
import 'package:app_e_commerce/shared/constant.dart';
import 'package:app_e_commerce/shared/costum.textField.dart';
import 'package:app_e_commerce/shared/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

//function to reset your password
  resetPassword() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Scafffold,
      appBar: AppBar(
        title: const Text(
          "Reset Password",
          style:
              TextStyle(color: titleAppbar, fontFamily: "myfont", fontSize: 35),
        ),
        elevation: 0,
        backgroundColor: apparAndBottom,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Enter your email to rest your password.",
                    style: TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 33,
                ),
                TextFormField(
                    // we return "null" when something is valid
                    validator: (email) {
                      return email!.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? null
                          : "Enter a valid email";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Email : ",
                        suffixIcon: const Icon(Icons.email))),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      resetPassword();
                    } else {
                      showSnackBar(context, "ERROR");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(apparAndBottom),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Reset Password",
                          style: TextStyle(fontSize: 19, color: titleAppbar),
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
