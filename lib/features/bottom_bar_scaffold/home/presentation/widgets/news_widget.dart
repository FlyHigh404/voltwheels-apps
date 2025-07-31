import 'package:flutter/material.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.imageNews,
    required this.badge,
    this.title,
    required this.badgeDiscount,
    this.label,
    this.bannerText,
  });

  final String imageNews;
  final String badge;
  final String? title;
  final String badgeDiscount;
  final String? label;
  final String? bannerText;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        height: 180,
        width: 180,
        child: Stack(children: [
          Stack(
            children: [
              Image.asset(
                imageNews,
                fit: BoxFit.fill,
              ),
              Positioned(
                top: -5,
                right: -5,
                child: Image.asset(
                  badgeDiscount,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: 200,
              padding: const EdgeInsets.only(
                bottom: 10.0,
                left: 6.0,
                right: 6.0,
                top: 4.0,
              ),
              decoration: const BoxDecoration(
                color: AppPallete.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    badge,
                    width: 75,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    bannerText ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  Text(
                    title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    label ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppPallete.blackGrayColor,
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
