import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/features/bottom_bar_scaffold/home/presentation/widgets/notification_widget.dart';
import 'package:voltwheels_mobile/features/volt-rent/domain/entities/volt_rent_vechile.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_controller.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/widgets/volt_rent_text_field.dart';
import 'package:voltwheels_mobile/routes/route.dart';

import '../widgets/volt_rent_location_dropdown.dart';

class VoltRentMainPage extends GetView<VoltRentController> {
  const VoltRentMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.offAllNamed(
                              RouteName.bottomBar,
                            );
                          },
                          icon: const Icon(
                            Iconsax.arrow_left_copy,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          width: 140,
                          height: 40,
                          child: VoltRentLocationDropdown(),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const NotificationWidget(),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(RouteName.voltRentOrder);
                        },
                        icon: const Icon(Iconsax.textalign_justifyright_copy),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const VoltRentTextField(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.filter_search,
                        color: AppPallete.primaryColor,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Rekomendasi",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "Variasi EV keren untuk kamu",
                      style: TextStyle(
                        color: AppPallete.blackGrayColor,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    IconButtonArrowLeft(),
                  ],
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    VoltRentRecommendationCard(
                      vehicle: carouselDummy.first,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    VoltRentRecommendationCard(vehicle: carouselDummy[1])
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      VoltRentButtonFilter(
                        label: "Skuter Listrik",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      VoltRentButtonFilter(
                        isActive: true,
                        label: "Motor Listrik",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      VoltRentButtonFilter(
                        label: "Mobil Listrik",
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
                  "Cocok buat kamu",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Ini nih motor listrik yang jadi primadona",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppPallete.blackGrayColor.withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const IconButtonArrowLeft(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var vehicle = controller.voltRentVechileList[index];
                    return VoltRentVehicleCard(
                      onTap: () {
                        Get.toNamed(RouteName.voltRentDetail,
                            arguments: vehicle);
                      },
                      voltRentVehicle: vehicle,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      width: Get.width,
                      height: 2,
                      decoration: const BoxDecoration(
                        color: AppPallete.grayColor,
                      ),
                    );
                  },
                  itemCount: controller.voltRentVechileList.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VoltRentVehicleCard extends StatelessWidget {
  const VoltRentVehicleCard({
    super.key,
    this.onTap,
    this.isOrder = false,
    this.remainTime = "",
    required this.voltRentVehicle,
  });

  final VoltRentVehicle voltRentVehicle;
  final VoidCallback? onTap;
  final bool isOrder;
  final String remainTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    voltRentVehicle.imagePath,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: const BoxDecoration(
                  color: AppPallete.whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: isOrder
                    ? Text(
                        remainTime,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppPallete.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                      )
                    : Row(
                        children: [
                          const Icon(
                            Iconsax.location,
                            color: AppPallete.primaryColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            voltRentVehicle.distance,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppPallete.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                    ),
                          ),
                        ],
                      ),
              ),
            ),
          ]),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                voltRentVehicle.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Rp. ${voltRentVehicle.price} / ${voltRentVehicle.qty}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppPallete.primaryColor,
                    ),
              ),
              Row(
                children: [
                  Text(
                    "${voltRentVehicle.speed} km/jam",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppPallete.blackGrayColor,
                          fontSize: 10,
                        ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppPallete.blackGrayColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Iconsax.user,
                    color: AppPallete.blackGrayColor,
                    size: 10,
                  ),
                  Text(
                    voltRentVehicle.capacity,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppPallete.blackGrayColor,
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: AppPallete.primaryColor,
                    size: 15,
                  ),
                  Text(
                    voltRentVehicle.rating,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppPallete.blackGrayColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                  ),
                  const SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    "| ",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppPallete.blackGrayColor,
                          fontSize: 10,
                        ),
                  ),
                  SizedBox(
                    width: 140,
                    child: Text(
                      voltRentVehicle.desc,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppPallete.blackGrayColor,
                            fontSize: 10,
                          ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class IconButtonArrowLeft extends StatelessWidget {
  const IconButtonArrowLeft({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(31, 171, 62, 0.3),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Iconsax.arrow_right_1_copy,
        size: 14,
        color: AppPallete.primaryColor,
      ),
    );
  }
}

class VoltRentButtonFilter extends StatelessWidget {
  const VoltRentButtonFilter({
    super.key,
    this.isActive = false,
    this.onTap,
    required this.label,
  });

  final bool isActive;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromRGBO(31, 171, 62, 0.1)
              : AppPallete.grayLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: isActive
                    ? AppPallete.primaryColor
                    : AppPallete.blackGrayColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class VoltRentRecommendationCard extends StatelessWidget {
  const VoltRentRecommendationCard({
    super.key,
    required this.vehicle,
  });

  final VoltRentVehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.voltRentDetail, arguments: vehicle);
      },
      child: Stack(
        children: [
          Container(
            width: 260,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(vehicle.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: AppPallete.primaryColor,
                ),
                Text(
                  vehicle.rating,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppPallete.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.location,
                        color: AppPallete.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        vehicle.location,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppPallete.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicle.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppPallete.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      vehicle.speed,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppPallete.whiteColor,
                          ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppPallete.whiteColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Iconsax.user,
                      color: AppPallete.whiteColor,
                      size: 16,
                    ),
                    Text(
                      vehicle.capacity,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppPallete.whiteColor,
                          ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
