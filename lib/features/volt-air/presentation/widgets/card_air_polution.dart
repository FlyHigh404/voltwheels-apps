import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/utils/get_aqi_color.dart';

import '../../../../core/theme/app_pallete.dart';

class CardAirPolution extends StatelessWidget {
  const CardAirPolution({
    super.key,
    required this.value,
    this.label = "0 µg/m³",
    this.color = AppPallete.mediumAir,
    this.location,
  });

  final String value;
  final String? label;
  final Color? color;
  final String? location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AQI US',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppPallete.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      value,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: AppPallete.whiteColor,
                          ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    const Icon(
                      Iconsax.wind_copy,
                      color: AppPallete.whiteColor,
                      size: 30,
                    ),
                  ],
                ),
                Text(
                  "PM2.5 | $label",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppPallete.whiteColor,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4.0,
          ),
          location != null
              ? Text(
                  location!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : const SizedBox.shrink(),
          RichText(
            text: TextSpan(
              text: "Kualitas Udara \n",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 10),
              children: [
                TextSpan(
                  text: getAirQualityInfo(int.parse(value)).description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ), // Example style
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
