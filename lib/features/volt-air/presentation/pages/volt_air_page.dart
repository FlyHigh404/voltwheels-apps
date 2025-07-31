import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/core/utils/date_utils.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/controllers/volt_air_controller.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/utils/aqi_converter.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/utils/get_aqi_color.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/widgets/bar_chart_forecast.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/widgets/card_air_polution.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/widgets/gradient_button.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/widgets/volt_air_appbbar.dart';

class VoltAirPage extends GetView<VoltAirController> {
  const VoltAirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltAirAppBar(),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return controller.activeTab.value
                ? const VoltAirAirQuality()
                : const VoltAirHealthImpact();
          },
        ),
      ),
    );
  }
}

class VoltAirHealthImpact extends GetView<VoltAirController> {
  const VoltAirHealthImpact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VoltAirTabBar(),
        const SizedBox(
          height: 16.0,
        ),
        VoltAirCurrentAirQuality(controller: controller),
        const SizedBox(
          height: 16.0,
        ),
        VoltAirSummaryQuality(controller: controller),
        const SizedBox(
          height: 16.0,
        ),
        VoltAirHealthImpactDetail(controller: controller),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}

class VoltAirHealthImpactDetail extends StatelessWidget {
  const VoltAirHealthImpactDetail({
    super.key,
    required this.controller,
  });

  final VoltAirController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppPallete.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1.5,
            color: AppPallete.grayColor,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dampak Langsung",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          getAirQualityInfo(controller.airQualityIndex.value.toInt())
              .healthImpact!
              .immediateImpact,
          const SizedBox(
            height: 12.0,
          ),
          Text(
            "Dampak Jangka Panjang",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          getAirQualityInfo(controller.airQualityIndex.value.toInt())
              .healthImpact!
              .longTermImpact,
          const SizedBox(
            height: 12.0,
          ),
          Text(
            "Tips Kesehatan",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          getAirQualityInfo(controller.airQualityIndex.value.toInt())
              .healthImpact!
              .healthTips,
          const SizedBox(
            height: 12.0,
          ),
          Text(
            "Rekomendasi Aktivitas",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          getAirQualityInfo(controller.airQualityIndex.value.toInt())
              .healthImpact!
              .activityRecommendations,
          const SizedBox(
            height: 12.0,
          ),
        ],
      ),
    );
  }
}

class VoltAirSummaryQuality extends StatelessWidget {
  const VoltAirSummaryQuality({
    super.key,
    required this.controller,
  });

  final VoltAirController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: getAirQualityInfo(
          controller.airQualityIndex.value.toInt(),
        ).backgroundColor,
        border: Border(
          left: BorderSide(
            width: 6,
            color: getAirQualityInfo(
              controller.airQualityIndex.value.toInt(),
            ).color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ringkasan",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            getAirQualityInfo(
                  controller.airQualityIndex.value.toInt(),
                ).healthImpact?.summary ??
                '',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppPallete.blackColor,
                  fontWeight: FontWeight.w400,
                ),
          )
        ],
      ),
    );
  }
}

class VoltAirAirQuality extends GetView<VoltAirController> {
  const VoltAirAirQuality({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var listDaysOfWeek = getDaysOfWeek();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VoltAirTabBar(),
        const SizedBox(
          height: 16.0,
        ),
        VoltAirCurrentAirQuality(controller: controller),
        const SizedBox(
          height: 16,
        ),
        VoltAirNearbyAirQuality(controller: controller),
        const SizedBox(
          height: 16,
        ),
        VoltAirForecastAirQuality(
          listDaysOfWeek: listDaysOfWeek,
          controller: controller,
        )
      ],
    );
  }
}

class VoltAirForecastAirQuality extends StatelessWidget {
  const VoltAirForecastAirQuality({
    super.key,
    required this.listDaysOfWeek,
    required this.controller,
  });

  final List<DayOfWeekModel> listDaysOfWeek;
  final VoltAirController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prakiraan dan Histori Kualitas Udara',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 220,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppPallete.whiteColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppPallete.grayColor,
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppPallete.grayColor,
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Iconsax.wind,
                          color: AppPallete.primaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                DayOfWeekModel day = listDaysOfWeek[index];

                                return Obx(
                                  () => InkWell(
                                    onTap: () {
                                      dateTimeToUnix(day.date);
                                      dateTimeToUnix(
                                        day.date.add(
                                          const Duration(days: 1),
                                        ),
                                      );
                                      controller.updateDaysOfWeek(day);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 0,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: controller.currentDayOfWeek.value
                                                    .dayName ==
                                                day.dayName
                                            ? AppPallete.grayColor
                                            : AppPallete.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        day.dayName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 11,
                                              fontWeight: controller
                                                          .currentDayOfWeek
                                                          .value
                                                          .dayName ==
                                                      day.dayName
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: listDaysOfWeek.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => controller.loadingForecastAirQuality.value
                      ? const VoltAirLoading()
                      : controller
                              .forecastAirQualityResponse.value.list.isNotEmpty
                          ? const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: BarChartForecast(),
                              ),
                            )
                          : const Text("Data Prakiraan Tidak Ada"),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class VoltAirNearbyAirQuality extends StatelessWidget {
  const VoltAirNearbyAirQuality({
    super.key,
    required this.controller,
  });

  final VoltAirController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(
            'Kualitas Sekitar',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              'Ketahui udara di sekitar ${controller.currentPosition.value.replaceAll(',', '')}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppPallete.blackGrayColor,
                  ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 160,
          child: Obx(
            () => controller.loadingNearbyAirQuality.value
                ? const VoltAirLoading()
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.nearbyAirQualityResponse.length,
                    itemBuilder: (BuildContext context, int index) {
                      var location = controller.nearbyLocation[index];
                      var qualityComponents = controller
                          .nearbyAirQualityResponse[index]
                          .list
                          .first
                          .components;

                      if (controller.nearbyLocation[index].contains(',')) {
                        return const SizedBox.shrink();
                      }

                      AQICalculator calc = AQICalculator(
                        pm25: qualityComponents.pm2_5,
                        pm10: qualityComponents.pm10,
                        co: qualityComponents.co,
                        so2: qualityComponents.so2,
                        no2: qualityComponents.no2,
                      );

                      var indexAQI = calc.calculateOverallAQI();

                      return Padding(
                        padding: index + 1 == controller.nearbyLocation.length
                            ? const EdgeInsets.only(right: 16)
                            : EdgeInsets.zero,
                        child: CardAirPolution(
                          value: indexAQI.toStringAsFixed(0),
                          label:
                              '${(controller.nearbyAirQualityResponse[index].list.first.components.pm2_5 / 5).toStringAsFixed(0)} µg/m³',
                          location: location,
                          color: getAirQualityInfo(indexAQI.toInt()).color,
                        ),
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}

class VoltAirLoading extends StatelessWidget {
  const VoltAirLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: AppPallete.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: AppPallete.blackGrayColor,
                spreadRadius: 1,
                blurRadius: 1.5,
                blurStyle: BlurStyle.outer,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Loading...",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppPallete.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class VoltAirCurrentAirQuality extends StatelessWidget {
  const VoltAirCurrentAirQuality({
    super.key,
    required this.controller,
  });

  final VoltAirController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          decoration: BoxDecoration(
            color: getAirQualityInfo(controller.airQualityIndex.value.toInt())
                .backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.location,
                            color: AppPallete.mediumGrayColor,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            child: Text(
                              controller.currentPosition.value,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.getCurrentPosition();
                    },
                    icon: const Icon(Iconsax.refresh_circle_copy),
                  ),
                ],
              ),
              Row(
                children: [
                  Obx(
                    () => CardAirPolution(
                      value:
                          controller.airQualityIndex.value.toStringAsFixed(0),
                      label:
                          "${controller.currentAirQualityResponse.value.list.isNotEmpty ? (controller.currentAirQualityResponse.value.list.first.components.pm2_5 / 5).toStringAsFixed(0) : 0} µg/m³",
                      color: getAirQualityInfo(
                        controller.airQualityIndex.value.toInt(),
                      ).color,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kualitas",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppPallete.blackGrayColor,
                                    ),
                          ),
                          Text(
                            getAirQualityInfo(
                              controller.airQualityIndex.value.toInt(),
                            ).description,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                          ),
                          Text(
                            "Kualitas udara dapat diterima. Terakhir diperbarui pada ${controller.currentAirQualityResponse.value.list.isNotEmpty ? convertTimestampToHHMM(controller.currentAirQualityResponse.value.list.first.dt) : '00:00'}",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppPallete.blackGrayColor,
                                      fontSize: 9,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Icon(
                      getAirQualityInfo(
                        controller.airQualityIndex.value.toInt(),
                      ).icon,
                      color: getAirQualityInfo(
                        controller.airQualityIndex.value.toInt(),
                      ).color,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class VoltAirTabBar extends GetView<VoltAirController> {
  const VoltAirTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        decoration: BoxDecoration(
            color: AppPallete.grayColor,
            borderRadius: BorderRadius.circular(50)),
        child: Obx(() {
          return Row(
            children: [
              Expanded(
                child: GradientButton(
                  onPressed: () {
                    controller.updateActiveTab(true);
                  },
                  text: 'Kualitas Udara',
                  isActive: controller.activeTab.value,
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: GradientButton(
                  onPressed: () {
                    controller.updateActiveTab(false);
                  },
                  text: 'Dampak Kesehatan',
                  isActive: !controller.activeTab.value,
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
