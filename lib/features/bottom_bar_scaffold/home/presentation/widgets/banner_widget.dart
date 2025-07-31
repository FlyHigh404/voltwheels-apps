import 'package:flutter/material.dart';

import '../../../../../core/assets/assets.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    this.firstElement = false,
  });

  final bool firstElement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      margin: firstElement ? const EdgeInsets.only(left: 12) : EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            Assets.banner1,
          ),
        ),
      ),
    );
  }
}
