import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/usecases/get_user_order.dart';

import '../../domain/entities/volt_rent_order.dart';

class VoltRentOrderController extends GetxController {
  final GetUserOrder getUserOrder;

  final RxList<VoltRentOrder> orderList = <VoltRentOrder>[].obs;

  VoltRentOrderController({
    required this.getUserOrder,
  });

  Future<void> fetchUserOrder() async {
    EasyLoading.show(status: "Loading");
    final response = await getUserOrder(
      FirebaseAuth.instance.currentUser?.uid ?? "",
    );

    response.fold(
      (error) => print(error),
      (orders) => orderList.assignAll(orders),
    );

    Future.delayed(const Duration(seconds: 1), () => EasyLoading.dismiss());
  }

  @override
  void onInit() {
    fetchUserOrder();
    super.onInit();
  }
}
