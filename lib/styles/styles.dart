import 'package:flutter/material.dart';

final primary = const Color(0xFFB6236C);
final blackb = const Color(0xFF565656);
final dullblack = const Color(0xFF565656).withOpacity(0.36);
final dblack = const Color(0xFF565656).withOpacity(0.44);
final blackc = const Color(0xFF565656).withOpacity(0.59);
final boldblack = const Color(0xFF565656).withOpacity(0.84);
final blacka = const Color(0xFF565656).withOpacity(0.91);
final lightblack = const Color(0xFF565656).withOpacity(0.69);
final bglight = const Color(0xFFf5f5f5);
final bgcolor = const Color(0xFFeeeeee);
final yellow = const Color(0xFFfefe78);
final red = const Color(0xFFff5757);
final darkgreen = const Color(0xFF1c5b10).withOpacity(0.40);
final lightwhite = const Color(0xFFffffff).withOpacity(0.76);
final redbtn = const Color(0xFFfe2424);
final blue = const Color(0xFF038be6);
final secondary = const Color(0xFFBE9063);

//-----------------------------------------51---

//---------------------------------------102----------
final whited = const Color(0xFFF5F5F5);

final google = const Color(0xFFDD4B39);
final facebook = const Color(0xFF3151BD);
final twitter = const Color(0xFF50ABF1);
final darkTextb = const Color(0xFF343434);
//.................................. Roboto Regular ....................................

TextStyle textwhitesmall() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    letterSpacing: 0.5,
    color: Colors.white,
    fontFamily: 'RobotoRegular',
  );
}

TextStyle textOS() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
    color: darkTextb,
    fontFamily: 'OpenSansLight',
  );
}

TextStyle textwhites() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 11.0,
    letterSpacing: 0.5,
    color: Colors.white,
    fontFamily: 'RobotoRegular',
  );
}

TextStyle subTitleWhite() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.white,
  );
}

TextStyle subBoldTitleStyle() {
  return new TextStyle(
    fontSize: 16.0,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.0,
  );
}

TextStyle textredsmall() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 11.0,
    letterSpacing: 0.5,
    color: red,
    fontFamily: 'RobotoRegular',
  );
}

TextStyle textwhite() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    letterSpacing: 0.5,
    color: lightwhite,
    fontFamily: 'RobotoRegular',
  );
}

TextStyle textsmallregular() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13.0,
    letterSpacing: 0.3,
    color: blacka,
    fontFamily: 'RobotoRegular',
  );
}

TextStyle textsmallbold() {
  return new TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15.0,
    letterSpacing: 0.3,
    color: boldblack,
    fontFamily: 'RobotoRegular',
  );
}

//.................................. RobotoMedium ....................................

TextStyle textmediumblack() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 19.0,
    letterSpacing: 0.5,
    color: blackb,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textmediumblacka() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    letterSpacing: 0.6,
    color: blacka,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textlightblack() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    letterSpacing: 0.3,
    color: lightblack,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textlight() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    letterSpacing: 0.3,
    color: blackb,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textlightblackh() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    letterSpacing: 0.3,
    color: lightblack,
    height: 1.3,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textmediumb() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    letterSpacing: 0.3,
    color: blackb,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textmediumblue() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    letterSpacing: 0.3,
    color: blue,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textblueblack() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    color: blue,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textdullblack() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    letterSpacing: 0.3,
    color: dullblack,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textdblack() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    letterSpacing: 0.3,
    color: dblack,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textblackc() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    letterSpacing: 0.3,
    color: blackc,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textblack() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 11.0,
    letterSpacing: 0.3,
    height: 1.3,
    color: dblack,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textmediumsmall() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: blackb,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textmediumsm() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    color: blackb,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textsmwhite() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 10.0,
    color: Colors.white,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textmediumwhite() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    letterSpacing: 0.5,
    color: Colors.white,
    fontFamily: 'RobotoMedium',
  );
}

TextStyle textred() {
  return new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
    letterSpacing: 0.3,
    color: red,
    fontFamily: 'RobotoMedium',
  );
}

//.................................. RobotoBold ....................................

TextStyle textboldsmall() {
  return new TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 13.0,
    color: red,
    fontFamily: 'RobotoBold',
  );
}

TextStyle textboldblack() {
  return new TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 13.0,
    color: boldblack,
    fontFamily: 'RobotoBold',
  );
}

TextStyle textboldSmall() {
  return new TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 10.0,
    color: dullblack,
    fontFamily: 'RobotoBold',
  );
}
