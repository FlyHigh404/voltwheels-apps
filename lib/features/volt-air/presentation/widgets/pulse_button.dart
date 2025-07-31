import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/routes/route.dart';

class PulseButton extends StatefulWidget {
  const PulseButton({super.key});

  @override
  _PulseButtonState createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(75),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPallete.grayColor.withOpacity(0.2),
              border: Border.all(
                color: AppPallete.whiteColor,
                width: 1,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppPallete.grayColor.withOpacity(0.2),
                border: Border.all(
                  color: AppPallete.whiteColor,
                  width: 1,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPallete.grayColor.withOpacity(0.2),
                  border: Border.all(
                    color: AppPallete.whiteColor,
                    width: 1,
                  ),
                ),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.2).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppPallete.whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.offNamed(RouteName.voltAir);
                      },
                      icon: const Icon(
                        Iconsax.scan,
                        color: AppPallete.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
