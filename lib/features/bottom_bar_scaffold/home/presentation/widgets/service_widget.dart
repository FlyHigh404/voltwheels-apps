import 'package:flutter/material.dart';

import '../../../../../core/theme/app_pallete.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget(
      {super.key,
      this.title,
      required this.imagePath,
      this.color = AppPallete.primaryColor,
      this.onTap,
      this.isActive = true});

  final String? title;
  final String imagePath;
  final Color color;
  final VoidCallback? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          isActive
              ? Image.asset(
                  imagePath,
                  width: 60,
                  height: 60,
                )
              : Image.asset(
                  imagePath,
                  width: 60,
                  height: 60,
                  color: AppPallete.whiteColor,
                  colorBlendMode: BlendMode.saturation,
                ),
          const SizedBox(
            height: 4,
          ),
          !isActive
              ? Text(
                  'Volt $title',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppPallete.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                )
              : RichText(
                  text: TextSpan(
                    text: 'Volt',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                    children: [
                      TextSpan(
                        text: title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppPallete.blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
