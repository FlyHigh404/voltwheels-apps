import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/core/utils/date_utils.dart';
import 'package:voltwheels_mobile/core/utils/num_utils.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_detail_controller.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_main_page.dart';
import 'package:voltwheels_mobile/routes/route.dart';

import '../widgets/volt_rent_expandable_text.dart';

class VoltRentDetailPage extends GetView<VoltRentDetailController> {
  const VoltRentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            controller.voltRentVehicle.value.imagePath),
                        scale: 4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Iconsax.arrow_left_2,
                            color: AppPallete.whiteColor,
                            size: 30,
                          ),
                        ),
                        Text(
                          controller.voltRentVehicle.value.name,
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                            color: AppPallete.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  "${controller.voltRentVehicle.value.name} 2024",
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    PannableRatingBar(
                      rate: 5,
                      items: List.generate(
                          5,
                              (index) =>
                          const RatingWidget(
                            selectedColor: AppPallete.primaryColor,
                            unSelectedColor: AppPallete.grayColor,
                            child: Icon(
                              Icons.star_rounded,
                              size: 15,
                            ),
                          )),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      controller.voltRentVehicle.value.rating,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                        color: AppPallete.blackGrayColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: ExpandableText(
                  text: controller.voltRentVehicle.value.longDesc,
                  // You can set the maximum number of lines to display before expanding
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Tinjauan Kendaraan",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CardDetailVechile(
                        title: 'Kapasitas',
                        body:
                        '${controller.voltRentVehicle.value.capacity} Orang',
                        icon: const Icon(
                          Iconsax.profile_2user,
                          size: 20,
                          color: AppPallete.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CardDetailVechile(
                        title: 'Daya',
                        body:
                        '${controller.voltRentVehicle.value.energy} kWh/km',
                        icon: const Icon(
                          Icons.bolt_rounded,
                          size: 20,
                          color: AppPallete.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CardDetailVechile(
                        title: 'Kecepatan',
                        body:
                        '${controller.voltRentVehicle.value.speed} km/jam',
                        icon: const Icon(
                          Iconsax.speedometer,
                          size: 20,
                          color: AppPallete.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Durasi Penyewaan",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    var duration = controller.rentDurationList[index];

                    return Obx(() {
                      return VoltRentButtonFilter(
                        isActive:
                        controller.selectedRentDuration.value == index,
                        label: formatDuration(duration),
                        onTap: () {
                          controller.updateSelectedRentDuration(index);
                        },
                      );
                    });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: controller.rentDurationList.length,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.19,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration:
        const BoxDecoration(color: AppPallete.whiteColor, boxShadow: [
          BoxShadow(
            color: AppPallete.blackGrayColor,
            offset: Offset(0, -2),
            blurRadius: 15.0,
            spreadRadius: 2.0,
          )
        ]),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.empty_wallet,
                      size: 15,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Bayar via",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Icon(
                      Iconsax.arrow_right_3_copy,
                      size: 12,
                    ),
                  ],
                ),
                Text(
                  "Pilih metode pembayaran",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                    color: AppPallete.redColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(28, 32, 28, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total bayar",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                          color: AppPallete.grayColor.withOpacity(0.8),
                        ),
                      ),
                      Obx(() {
                        return Text(
                          "Rp. ${formatDigit(
                              controller.totalPrice.value.toString())}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                            color: AppPallete.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          RouteName.voltRentPayment,
                          arguments: {
                            "vehicle": controller.voltRentVehicle.value,
                            "total": controller.totalPrice.value,
                            "duration": controller.rentDurationList[
                            controller.selectedRentDuration.value],
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        backgroundColor: AppPallete.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Pesan Sekarang!",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppPallete.whiteColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(
                            Iconsax.arrow_right_1_copy,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardDetailVechile extends StatelessWidget {
  const CardDetailVechile({
    super.key,
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 16.0,
          ),
          decoration: BoxDecoration(
            color: AppPallete.greenLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: AppPallete.primaryColor,
            ),
          ),
          child: icon,
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .bodySmall!
              .copyWith(
            color: AppPallete.blackGrayColor,
          ),
        ),
        Text(
          body,
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge!
              .copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
