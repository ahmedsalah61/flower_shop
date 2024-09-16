import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  const Color.fromARGB(255, 222, 70, 60);
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 5),
    content: Text(text),
    action: SnackBarAction(label: "close", onPressed: () {}),
  ));
}
