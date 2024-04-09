import 'dart:ui';

import 'package:Hostinaar/Controller/UserController.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF004225);
const kSemiPrimaryColor = Color(0xFFF5F5DC);
const kSecondaryColor = Color(0xFFFFB000);
const kAdditionalColor = Color(0xFF1F1F39);

InputDecoration kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.grey[200],
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.white),
  ),
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.white),
  ),
);

UserController userController = UserController();