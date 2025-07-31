import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/theme/app_pallete.dart';
import '../widgets/pulse_button.dart';

class VoltAirLoadingPage extends StatelessWidget {
  const VoltAirLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background image
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.voltAirLoading),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Color overlay
            Container(
              width: Get.width,
              height: Get.height,
              color: AppPallete.primaryColor.withOpacity(0.65),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(-140, -140),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Iconsax.close_circle,
                        color: AppPallete.whiteColor,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Text(
                      "Hai, ${FirebaseAuth.instance.currentUser?.displayName} Bagaimana harimu?\n Yuk scan kualitas udara di sekitar kamu supaya\n kamu lebih aware!",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppPallete.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RippleAnimation(
                    color: AppPallete.grayColor,
                    delay: const Duration(milliseconds: 300),
                    repeat: true,
                    minRadius: 75,
                    ripplesCount: 3,
                    duration: const Duration(milliseconds: 3 * 300),
                    child: Stack(children: [
                      Transform.translate(
                        offset: const Offset(240, 190),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: AppPallete.redColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.wind_copy,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(270, 90),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: AppPallete.mediumAir,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.wind_copy,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(70, 180),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: AppPallete.dangerAir,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.wind_copy,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(90, 40),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: AppPallete.goodAir,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.wind_copy,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      ),
                      const PulseButton()
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
