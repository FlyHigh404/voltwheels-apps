import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/routes/route.dart';

import '../../../../core/theme/app_pallete.dart';

class VoltAirAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VoltAirAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPallete.whiteColor,
      surfaceTintColor: AppPallete.whiteColor,
      leading: IconButton(
        icon: const Icon(
          Iconsax.arrow_left_3_copy,
          size: 30,
        ),
        onPressed: () {
          Get.offNamed(RouteName.bottomBar);
        },
      ),
      title: Row(
        children: [
          Text(
            "VoltAir",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppPallete.primaryColor,
                ),
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(
            Iconsax.wind_copy,
            color: AppPallete.primaryColor,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
