import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/core/utils/date_utils.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/entities/volt_rent_vechile.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_order_controller.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_main_page.dart';
import 'package:voltwheels_mobile/routes/route.dart';

class VoltRentOrdersPage extends GetView<VoltRentOrderController> {
  const VoltRentOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var listVehicle = [...generateDummyVehicles(), ...carouselDummy];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesanan"),
        surfaceTintColor: AppPallete.whiteColor,
        backgroundColor: AppPallete.whiteColor,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: ListView.separated(
            itemCount: controller.orderList.length,
            itemBuilder: (BuildContext context, int index) {
              var order = controller.orderList[index];
              var vehicle = listVehicle.firstWhere(
                (e) => e.id == order.vehicleId,
              );
              bool isActive = order.expiryTime.isAfter(
                DateTime.now(),
              );

              return Stack(
                children: [
                  VoltRentVehicleCard(
                    onTap: () {
                      Get.toNamed(
                        RouteName.voltRentPayment,
                        arguments: {
                          "vehicle": vehicle,
                          "total": order.paymentDetails['transaction_details']
                              ['gross_amount'],
                          "duration": const Duration(hours: 1),
                          "order_id": order.orderId.toString(),
                          "active_stepper": 4,
                        },
                      );
                    },
                    voltRentVehicle: vehicle,
                    remainTime: getExpiryStatus(order.expiryTime),
                    isOrder: true,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: isActive
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: AppPallete.primaryGradient,
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppPallete.blackGrayColor,
                            ),
                      child: Text(
                        isActive ? "Aktif" : "Tidak Aktif",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppPallete.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ),
        );
      }),
    );
  }
}
