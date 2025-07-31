import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/auth/presentation/auth_login/controllers/auth_login_controller.dart';
import 'package:voltwheels_mobile/init_dependencies.dart';

class AuthLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthLoginController(serviceLocator()));
  }

}