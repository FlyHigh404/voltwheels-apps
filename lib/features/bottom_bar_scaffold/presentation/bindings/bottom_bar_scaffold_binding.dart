import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:voltwheels_mobile/features/bottom_bar_scaffold/presentation/controllers/bottom_bar_scaffold_controller.dart';

import '../../../volt-rent/presentation/controllers/volt_rent_order_controller.dart';

class BottomBarScaffoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomBarScaffoldController());
    Get.lazyPut(() => VoltRentOrderController(getUserOrder: GetIt.instance()));
  }

}