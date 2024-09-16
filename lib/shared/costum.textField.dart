import 'package:app_e_commerce/shared/constant.dart';
import 'package:flutter/material.dart';

InputDecoration decorationTextfield = InputDecoration(
  // To delete borders
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: apparAndBottom),
  ),
  // fillColor: Colors.red,
  filled: true,
  contentPadding: EdgeInsets.all(10),
);
