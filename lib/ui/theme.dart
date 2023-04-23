import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const Color mainColor = Color(0xFF2FD1C5); //buttons,toggles
const Color backg1 = Color(0xFFF5FBFF);
const Color backg2 = Colors.white;
const Color textColor1 = Color(0xFF00394C);
const Color textColor2 = Color(0xFF585A66);
const Color msgColor1 = Color(0xFFCDF3F3);
const Color msgColor2 = Color(0xFFDDE2E5);
const Color input1 = Color(0xFFC4D7FF);
//inputs
const inputDeco = InputDecoration(
  fillColor: backg1,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: input1, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  floatingLabelStyle: TextStyle(color: textColor1),
);
const dropDownDeco = InputDecoration(
  fillColor: backg1,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: input1),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: input1),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  floatingLabelStyle: TextStyle(color: textColor1),
);

//loading
class Themes {
  static final light = ThemeData(
    primaryColor: mainColor,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: Colors.red,
    brightness: Brightness.dark,
  );
}
