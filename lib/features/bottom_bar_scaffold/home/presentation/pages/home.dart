import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/core/assets/assets.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';

import '../../../../../routes/route.dart';
import '../widgets/banner_widget.dart';
import '../widgets/button_textfield.dart';
import '../widgets/news_widget.dart';
import '../widgets/notification_widget.dart';
import '../widgets/service_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Row(
            children: [
              const ButtonTextField(),
              const SizedBox(
                width: 10,
              ),
              const NotificationWidget(),
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openEndDrawer();
                },
                icon: const Icon(Iconsax.textalign_justifyright_copy),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BannerWidget(
                firstElement: true,
              ),
              SizedBox(
                width: 20,
              ),
              BannerWidget(),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Layanan',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Row(
                children: [
                  Text(
                    'Pilih layanan sesukamu di',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppPallete.blackGrayColor,
                        ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Voltwheels',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppPallete.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppPallete.primaryColor,
                                  ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                            color: AppPallete.greenAccentColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.arrow_right_1_copy,
                            size: 14,
                            color: AppPallete.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceWidget(
                      title: 'Rent',
                      onTap: () {
                        Get.toNamed(RouteName.voltRent);
                      },
                      imagePath: Assets.voltRent,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const ServiceWidget(
                      title: 'Food',
                      isActive: false,
                      imagePath: Assets.voltFood,
                      color: AppPallete.voltFoodColor,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const ServiceWidget(
                      title: 'Charge',
                      isActive: false,
                      imagePath: Assets.voltCharge,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ServiceWidget(
                      title: 'Air',

                      onTap: () {
                        Get.toNamed(RouteName.voltAirLoading);
                      },
                      imagePath: Assets.voltAir,
                      color: AppPallete.voltAirColor,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const ServiceWidget(
                      title: 'Express',
                      isActive: false,
                      imagePath: Assets.voltExpress,
                      color: AppPallete.voltExpressColor,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const ServiceWidget(
                      title: 'Move',
                      isActive: false,
                      imagePath: Assets.voltMove,
                      color: AppPallete.voltMoveColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Stay up-to-date",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  Text(
                    'Ssh, buruan cek biar gak ketinggalan...',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppPallete.blackGrayColor,
                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
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
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: NewsWidget(
                      badge: Assets.voltRentBadge,
                      badgeDiscount: Assets.discount15,
                      imageNews: Assets.news1,
                      title: 'Kini tersedia skuter listrik...',
                      label: 'skuter | voltwheels | rental',
                      bannerText: 'Unit Baru!',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: NewsWidget(
                      badge: Assets.voltExpressBadge,
                      badgeDiscount: Assets.discount60,
                      imageNews: Assets.news2,
                      title: 'Ambil antar tanpa ragu ...',
                      label: 'instant | voltwheels | pengiriman',
                      bannerText: 'Secepat Kilat!',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Container(
                width: Get.width,
                height: 160,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.news3), fit: BoxFit.fill),
                ),
              ),
              Container(
                width: Get.width,
                height: 160,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.news3), fit: BoxFit.fill),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
