import 'package:flutter/material.dart';

class AppPallete {
  static const Color primaryColor = Color(0xff1FAB3E);
  static const Color secondaryColor = Color(0xffF07137);
  static const Color blackColor = Color(0xff11232E);
  static const Color whiteColor = Color(0xffFAFAFA);
  static const Color grayColor = Color(0xffE6E6E6);
  static const Color blackGrayColor = Color.fromRGBO(13, 26, 16, 0.5);
  static const Color mediumGrayColor = Color.fromRGBO(54, 61, 55, 1);
  static const Color greenAccentColor = Color.fromRGBO(31, 171, 62, 0.3);
  static const Color greenLight = Color.fromRGBO(31, 171, 62, 0.04);
  static const Color grayLight = Color.fromRGBO(184, 184, 184, 0.2);

  static const Color dotColor = Color(0xffDBDBDB);

  static const Color gradientColor = Color(0xff52CC6D);
  static const Color gradient2Color = Color(0xff1FAB3E);

  static const Color sliderTextColor = Color(0xff2D332E);
  static const Color borderColor = Color(0xff2C322D);
  static const Color iconColor = Color(0xff686B6E);

  static const Color redColor = Color(0xffF24444);
  static const Color voltFoodColor = Color(0xffA11D1D);
  static const Color voltAirColor = Color(0xff1D6CA1);

  static const Color voltAirBackgroundColor =
      Color.fromRGBO(148, 171, 31, 0.15);
  static const Color mediumAir = Color.fromRGBO(148, 171, 31, 1);
  static const Color goodAir = Color.fromRGBO(31, 171, 61, 1);
  static const Color dangerAir = Color.fromRGBO(204, 102, 0, 1);
  static const Color veryDangerAir = Color.fromRGBO(204, 0, 0, 1);
  static const Color veryDangerAir2 = Color.fromARGB(116, 0, 204, 1);
  static const Color deathAir = Color.fromARGB(122, 0, 0, 1);

  static const Color voltAirVeryDangerBg = Color.fromRGBO(204, 0, 0, 0.15);
  static const Color voltAirGoodBg = Color.fromRGBO(31, 171, 61, 0.15);
  static const Color voltAirVeryDanger2 = Color.fromRGBO(116, 0, 204, 0.15);
  static const Color voltAirDeathAir = Color.fromRGBO(122, 0, 0, 0.15);

  static const Color voltExpressColor = Color(0xff1D6CA1);
  static const Color voltMoveColor = Color(0xff1DA13A);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppPallete.gradientColor, AppPallete.gradient2Color],
  );
}
