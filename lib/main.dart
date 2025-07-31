import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/core/theme/theme.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/binding/onboarding_binding.dart';
import 'package:voltwheels_mobile/features/splash_screen/pages/splash_screen_page.dart';
import 'package:voltwheels_mobile/init_dependencies.dart';
import 'package:voltwheels_mobile/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

  await initDependencies();

  runApp(const VoltWheelsApp());
}

class VoltWheelsApp extends StatelessWidget {
  const VoltWheelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: dotenv.env['APP_NAME'] ?? 'Voltwheels',
      theme: AppTheme.appTheme,
      themeMode: ThemeMode.light,
      getPages: routes,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      initialBinding: OnboardingBinding(),
      builder: EasyLoading.init(),
      home: const SplashScreenPage(),
    );
  }
}
