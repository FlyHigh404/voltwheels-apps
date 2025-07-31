import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/alert/ongoing_alert_pages.dart';
import 'package:voltwheels_mobile/features/auth/presentation/auth_login/bindings/auth_login_binding.dart';
import 'package:voltwheels_mobile/features/auth/presentation/auth_register/bindings/auth_register_binding.dart';
import 'package:voltwheels_mobile/features/auth/presentation/auth_login/pages/auth_login_page.dart';
import 'package:voltwheels_mobile/features/auth/presentation/auth_register/pages/auth_register_page.dart';
import 'package:voltwheels_mobile/features/bottom_bar_scaffold/presentation/bindings/bottom_bar_scaffold_binding.dart';
import 'package:voltwheels_mobile/features/bottom_bar_scaffold/presentation/pages/bottom_bar_scaffold.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/binding/onboarding_binding.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/pages/onboarding_pages.dart';
import 'package:voltwheels_mobile/features/splash_screen/pages/splash_screen_page.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/bindings/volt_air_binding.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/pages/volt_air_loading_page.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/pages/volt_air_page.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/bindings/volt_rent_binding.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_detail_page.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_main_page.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_orders_page.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_page.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_payment_page.dart';
import 'package:voltwheels_mobile/middlewares/middleware.dart';

abstract class RouteName {
  static const String splashScreen = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String bottomBar = '/bottom-bar';
  static const String voltAirLoading = '/volt-air-loading';
  static const String voltAir = '/volt-air';
  static const String voltRent = '/volt-rent';
  static const String voltRentMain = '/volt-rent-main';
  static const String voltRentDetail = '/volt-rent-detail';
  static const String voltRentPayment = '/volt-rent-payment';
  static const String voltRentOrder = '/volt-rent-order';
  static const String alert = '/alert';
}

final routes = [
  GetPage(
    name: RouteName.splashScreen,
    page: () => const SplashScreenPage(),
  ),
  GetPage(
      name: RouteName.onboarding,
      binding: OnboardingBinding(),
      page: () => const OnboardingPage(),
      middlewares: [AuthMiddleware()]),
  GetPage(
      name: RouteName.login,
      binding: AuthLoginBinding(),
      page: () => const AuthLoginPage(),
      middlewares: [AuthMiddleware()]),
  GetPage(
      name: RouteName.register,
      binding: AuthRegisterBinding(),
      page: () => const AuthRegisterPage(),
      middlewares: [AuthMiddleware()]),
  GetPage(
      name: RouteName.bottomBar,
      binding: BottomBarScaffoldBinding(),
      page: () => const BottomBarScaffold(),
      middlewares: [AuthMiddleware()]),
  GetPage(
    name: RouteName.voltAir,
    page: () => const VoltAirPage(),
    binding: VoltAirBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: RouteName.voltAirLoading,
    page: () => const VoltAirLoadingPage(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: RouteName.voltRent,
    binding: VoltRentBinding(),
    page: () => const VoltRentPage(),
    transition: Transition.cupertinoDialog,
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: RouteName.voltRentMain,
    binding: VoltRentBinding(),
    page: () => const VoltRentMainPage(),
    transition: Transition.cupertinoDialog,
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: RouteName.voltRentDetail,
    binding: VoltRentBinding(),
    page: () => const VoltRentDetailPage(),
    transition: Transition.cupertinoDialog,
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: RouteName.voltRentPayment,
    binding: VoltRentBinding(),
    page: () => const VoltRentPaymentPage(),
    transition: Transition.cupertinoDialog,
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: RouteName.voltRentOrder,
    binding: VoltRentBinding(),
    page: () => const VoltRentOrdersPage(),
    transition: Transition.cupertinoDialog,
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: RouteName.alert,
    page: () => const OngoingAlertPages(),
    transition: Transition.cupertinoDialog,
    middlewares: [AuthMiddleware()],
  ),

];
