import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/entities/volt_rent_vechile.dart';

class VoltRentDetailController extends GetxController {
  final Rx<VoltRentVehicle> voltRentVehicle =
      (Get.arguments as VoltRentVehicle).obs;
  final RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    totalPrice.value = int.parse(voltRentVehicle.value.price);
    super.onInit();
  }

  final RxList<Duration> rentDurationList = [
    const Duration(
      hours: 1,
    ),
    const Duration(
      hours: 2,
    ),
    const Duration(
      hours: 3,
    ),
    const Duration(
      days: 1,
    ),
    const Duration(
      days: 2,
    ),
  ].obs;

  final RxInt selectedRentDuration = 0.obs;

  void updateSelectedRentDuration(int val) {
    selectedRentDuration.value = val;
    updatePrice(
      int.parse(voltRentVehicle.value.price) * rentDurationList[val].inHours,
    );
  }

  void updatePrice(int price) {
    totalPrice.value = price;
  }
}
