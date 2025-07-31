import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../core/theme/app_pallete.dart';

class VoltRentTextField extends StatelessWidget {
  const VoltRentTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0.0),
          filled: true,
          fillColor: AppPallete.grayColor,
          prefixIcon: const Icon(
            Iconsax.search_normal_1_copy,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: AppPallete.borderColor,
              width: 0.5,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          hintText: "Mau berkendara pakai apa? ",
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppPallete.blackGrayColor,
                fontSize: 12,
              ),
        ),
      ),
    );
  }
}
