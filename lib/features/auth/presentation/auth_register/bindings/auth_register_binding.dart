import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/auth/presentation/auth_register/controllers/auth_register_controller.dart';
import 'package:voltwheels_mobile/init_dependencies.dart';

class AuthRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRegisterController(serviceLocator()));
  }
}
