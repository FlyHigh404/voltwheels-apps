import 'package:flutter/material.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';

class VoltRentGradientButton extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final VoidCallback onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final bool isActive;

  const VoltRentGradientButton({
    required this.text,
    this.gradient = AppPallete.primaryGradient,
    required this.onPressed,
    this.borderRadius = 30.0,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: padding,
        decoration: isActive
            ? BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
        )
            : const BoxDecoration(color: Colors.transparent),
        child: Center(
          child: Text(
            text,
            style: isActive
                ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppPallete.whiteColor, fontWeight: FontWeight.w600)
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppPallete.blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
