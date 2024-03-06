import 'dart:ui';

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF0C7075);
const kSecondaryColor = Color(0xFFEEA86C);
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
