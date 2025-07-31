import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/core/assets/assets.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/core/utils/num_utils.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_payment_controller.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_page.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/services/order_service.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/utils/rent_date.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/widgets/volt_rent_gradient_button.dart';
import 'package:voltwheels_mobile/routes/route.dart';

class VoltRentPaymentPage extends GetView<VoltRentPaymentController> {
  const VoltRentPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> stepperContent = [
      const VoltRentConfirmationWidget(),
      const VoltRentPaymentWidget(),
      const VoltRentSuccessPaymentWidget(),
      const VoltRentActive()
    ];

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () {
            return Text(
              controller.activeStepper.value == 4
                  ? "Pesanan Aktif"
                  : "Pembayaran",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: AppPallete.whiteColor,
        surfaceTintColor: AppPallete.whiteColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: VoltRentStepper(
                        index: 1,
                        isActive: controller.activeStepper.value >= 1,
                        label: "Konfirmasi",
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: VoltRentStepper(
                        index: 2,
                        isActive: controller.activeStepper.value >= 2,
                        label: "Pembayaran",
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: VoltRentStepper(
                        index: 3,
                        isActive: controller.activeStepper.value >= 4,
                        label: "Status sewa",
                      ),
                    ),
                  ],
                ),
              );
            }),
            Obx(
              () => stepperContent[controller.activeStepper.value - 1],
            ),
          ],
        ),
      ),
    );
  }
}

class VoltRentActive extends GetView<VoltRentPaymentController> {
  const VoltRentActive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoltRentPaymentController>(initState: (_) async {
      EasyLoading.show(status: "Loading");
      var response = await OrderService.getOrderByUserIdAndOrderId(
        FirebaseAuth.instance.currentUser!.uid,
        controller.orderId.value,
      );

      response.fold((l) {
        print(l);
      }, (order) {
        controller.voltRentOrder.value = order;
        controller.startCountdown(
          expiryTime: order!.expiryTime,
          startTime: DateTime.now(),
        );
      });
      Future.delayed(const Duration(seconds: 1), () {
        EasyLoading.dismiss();
      });
    }, builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              "Status Sewa",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              "Silahkan ambil kendaraan kamu pada navigasi yang"
              " tertera, durasi penyewaan berjalan"
              " sesuai dengan Durasi Sewa, have fun ya, VoltMates!",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppPallete.blackGrayColor,
                  ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const VoltRentDetailSewa(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              "Lokasi Pengambilan dan Pengembalian",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const VoltRentRentPlace(),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Sisa Durasi",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                controller.remainingTime.value == "00:00"
                    ? "Selesai"
                    : controller.remainingTime.value,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppPallete.primaryColor,
                    ),
              ),
            );
          }),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: VoltRentGradientButton(
              text: "Kembali ke halaman utama",
              isActive: true,
              borderRadius: 10,
              onPressed: () {
                Get.offAllNamed(RouteName.voltRentMain);
              },
            ),
          )
        ],
      );
    });
  }
}

class VoltRentSuccessPaymentWidget extends GetView<VoltRentPaymentController> {
  const VoltRentSuccessPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoltRentPaymentController>(
      initState: (_) {
        Future.delayed(
            const Duration(
              seconds: 5,
            ), () {
          controller.updateStepper(4);
        });
      },
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 48,
          ),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: AppPallete.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    spreadRadius: 1, blurRadius: 1, blurStyle: BlurStyle.outer)
              ],
            ),
            child: Column(
              children: [
                Text(
                  "SELAMAT!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppPallete.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Nomor Pesanan : ${controller.orderId} Pembayaran berhasil dilakukan.!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color.fromRGBO(45, 51, 46, 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  Icons.check_circle,
                  color: AppPallete.primaryColor,
                  size: 60,
                ),
                const SizedBox(
                  height: 25,
                ),
                VoltRentGradientButton(
                  isActive: true,
                  onPressed: () {
                    controller.updateStepper(4);
                  },
                  borderRadius: 10,
                  text: "Selesai",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VoltRentPaymentWidget extends GetView<VoltRentPaymentController> {
  const VoltRentPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "Menunggu Pembayaran",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "Scan QR Code berikut dengan E-Wallet kesayangan kamu untuk melanjutkan pembayaran.",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppPallete.blackGrayColor,
                ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppPallete.whiteColor,
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 0.1,
                  offset: Offset(0, 0),
                  blurRadius: 1.5,
                  color: AppPallete.blackGrayColor,
                )
              ],
            ),
            child: Column(
              children: [
                Obx(
                  () => Text(
                    controller.remainingTime.value,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  "Selesaikan pembayaran sebelum waktu habis",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppPallete.blackGrayColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Image.network(
                  controller.midtransResponse.value?.actions.firstOrNull?.url ??
                      "",
                  width: 250,
                  height: 250,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "Metode Pembayaran",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const VoltRentPaymentMethod(),
        const SizedBox(
          height: 8.0,
        ),
        const VoltRentPricingSummary(),
      ],
    );
  }
}

class VoltRentConfirmationWidget extends GetView<VoltRentPaymentController> {
  const VoltRentConfirmationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "Konfirmasi Pesanan",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "Silahkan konfirmasi pesanan kamu, pastikan sudah sesuai ya, VoltMates!",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppPallete.blackGrayColor,
                ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4,
          ),
          child: VoltRentLine(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "Detail Sewa",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const VoltRentDetailSewa(),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "Lokasi Pengambilan dan Pengembalian",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const VoltRentRentPlace(),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            "Metode Pembayaran",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const VoltRentPaymentMethod(),
        const SizedBox(
          height: 8.0,
        ),
        const VoltRentPricingSummary(),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10,
          ),
          child: VoltRentGradientButton(
            text: "Lanjutkan Pembayaran",
            onPressed: () => controller.onClickWebView(context),
            isActive: true,
            borderRadius: 15,
          ),
        ),
      ],
    );
  }
}

class VoltRentRentPlace extends GetView<VoltRentPaymentController> {
  const VoltRentRentPlace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Icon(
            Iconsax.location,
            color: AppPallete.primaryColor,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.voltRenVehicle.value.rentPlace.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.7,
                  child: Text(
                    controller.voltRenVehicle.value.rentPlace.location,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppPallete.blackGrayColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          const Icon(
            Iconsax.arrow_down_1_copy,
            size: 15,
          ),
        ],
      ),
    );
  }
}

class VoltRentPricingSummary extends GetView<VoltRentPaymentController> {
  const VoltRentPricingSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          VoltRentPricingLabel(
            label: "Subtotal",
            price: controller.totalPrice ?? 0,
          ),
          const VoltRentPricingLabel(
            label: "Biaya Layanan",
            price: 5000,
          ),
          const SizedBox(
            height: 15,
          ),
          VoltRentPricingLabel(
            label: "Total Bayar",
            price: controller.totalPrice ?? 0,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            priceStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppPallete.primaryColor,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Sudah termasuk pajak",
                style: TextStyle(
                  color: AppPallete.blackGrayColor,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VoltRentPaymentMethod extends StatelessWidget {
  const VoltRentPaymentMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 40,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppPallete.whiteColor,
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 1,
                  color: AppPallete.blackGrayColor,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Image.asset(Assets.voltRentQris),
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            "Scan QR Code",
          ),
        ],
      ),
    );
  }
}

class VoltRentPricingLabel extends StatelessWidget {
  const VoltRentPricingLabel(
      {super.key,
      required this.label,
      required this.price,
      this.labelStyle,
      this.priceStyle});

  final String label;
  final int price;
  final TextStyle? labelStyle;
  final TextStyle? priceStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle ??
              const TextStyle(
                color: AppPallete.blackGrayColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          "Rp. ${formatDigit(price.toString())}",
          style: priceStyle ??
              const TextStyle(
                color: AppPallete.blackGrayColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class VoltRentDetailSewa extends GetView<VoltRentPaymentController> {
  const VoltRentDetailSewa({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16.0,
        left: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VoltRentUl(
            label: "Jenis EV",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "${controller.voltRenVehicle.value.name} 2024",
              style: const TextStyle(
                color: AppPallete.blackGrayColor,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const VoltRentUl(
            label: "Durasi Sewa",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              generateRentalDetails(controller.rentDuration),
              style: const TextStyle(
                color: AppPallete.blackGrayColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VoltRentUl extends StatelessWidget {
  const VoltRentUl({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppPallete.blackColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class VoltRentStepper extends StatelessWidget {
  const VoltRentStepper({
    super.key,
    required this.index,
    this.isActive = false,
    required this.label,
  });

  final int index;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isActive ? AppPallete.primaryColor : AppPallete.blackGrayColor,
          ),
          child: Text(
            "$index",
            style: const TextStyle(
              fontSize: 10,
              color: AppPallete.whiteColor,
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
          ),
        ),
      ],
    );
  }
}
