import 'package:flutter/material.dart';

const appBarColor = Color.fromRGBO(239, 239, 239, 1);
const greyColor = Color.fromRGBO(60, 60, 67, 0.36);
const greyColorNoOpacity = Color.fromRGBO(60, 60, 67, 1);
const blueColor = Color.fromRGBO(0, 112, 255, 1);
const chatBackgroundColor = Color.fromRGBO(233, 233, 235, 1);
const blackTextColor = Color.fromRGBO(0, 0, 0, 1);
const whiteTextColor = Color.fromRGBO(255, 255, 255, 1);
const orangeColor = Color.fromRGBO(255, 114, 71, 1);


ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: 'SFProText',
);

TextStyle regular17 = const TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w400,
  fontSize: 17,
  height: 22 / 17,
);

TextStyle medium11 = const TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w500,
  fontSize: 11,
  height: 13 / 11,
);

TextStyle regular11 = const TextStyle(
  fontFamily: 'SFProText',
  fontWeight: FontWeight.w400,
  fontSize: 11,
  height: 13 / 11,
);
