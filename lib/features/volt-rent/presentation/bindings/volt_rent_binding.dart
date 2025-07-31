import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_controller.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_order_controller.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_payment_controller.dart';

import '../controllers/volt_rent_detail_controller.dart';

class VoltRentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoltRentController());
    Get.lazyPut(() => VoltRentPaymentController());
    Get.lazyPut(() => VoltRentDetailController());
    Get.lazyPut(() => VoltRentOrderController(getUserOrder: GetIt.instance()));
  }
}
