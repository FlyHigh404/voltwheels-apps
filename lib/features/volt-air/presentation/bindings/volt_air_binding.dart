import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/controllers/volt_air_controller.dart';
import 'package:voltwheels_mobile/init_dependencies.dart';

class VoltAirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => VoltAirController(
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
