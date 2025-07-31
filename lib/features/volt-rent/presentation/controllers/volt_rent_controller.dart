import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../domain/entities/volt_rent_vechile.dart';

class VoltRentController extends GetxController {
  RxList<VoltRentVehicle> voltRentVechileList =
      <VoltRentVehicle>[...generateDummyVehicles()].obs;
  final RxList<String> items = [
    'Surabaya',
    'Sidoarjo',
    'Malang',
    'Gresik',
  ].obs;

  ScrollController scrollController = ScrollController();
  RxDouble scrollPosition = 0.0.obs;

  final RxString selectedLocation = 'Surabaya'.obs;

  updateLocation(String? value) {
    if (value != null) {
      selectedLocation.value = value;
    }
  }

  void scrollToMiddle() {
    if (!scrollController.hasClients) return;

    double containerWidth = 200.0;
    double paddingWidth = 10.0;
    int numberOfContainers = 3;

    double totalWidth = (containerWidth * numberOfContainers) +
        (paddingWidth * (numberOfContainers + 1));

    double middlePosition =
        totalWidth / 2 - MediaQuery.of(Get.context!).size.width / 2;

    scrollPosition.value = middlePosition;

    scrollController.animateTo(
      middlePosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollToMiddle();
      }
    });

    ever(scrollController.hasClients.obs, (bool? hasClients) {
      if (hasClients == true) {
        scrollToMiddle();
      }
    });

    super.onInit();
  }
}
