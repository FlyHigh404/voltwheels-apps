import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../core/theme/app_pallete.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          Iconsax.notification,
          size: 35,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 20,
            padding: const EdgeInsets.only(
              top: 2,
            ),
            height: 20,
            decoration: const BoxDecoration(
                color: AppPallete.redColor, shape: BoxShape.circle),
            child: Text(
              "20",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppPallete.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}