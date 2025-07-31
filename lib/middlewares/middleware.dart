import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voltwheels_mobile/routes/route.dart';

final List<String> protectedRoutes = <String>[
  RouteName.bottomBar,
];

final List<String> publicRoutes = [
  RouteName.login,
  RouteName.register,
  RouteName.onboarding
];

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null && protectedRoutes.contains(route)) {
      return const RouteSettings(name: RouteName.login);
    }

    if (user != null && publicRoutes.contains(route)) {
      return const RouteSettings(name: RouteName.bottomBar);
    }

    return null;
  }
}
