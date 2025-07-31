import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/controllers/volt_rent_controller.dart';

import '../../../../core/theme/app_pallete.dart';

class VoltRentLocationDropdown extends GetView<VoltRentController> {
  const VoltRentLocationDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            customButton: const DropdownButtonTrigger(),
            items: controller.items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: controller.selectedLocation.value,
            onChanged: (String? value) {
              controller.updateLocation(value);
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppPallete.whiteColor,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: WidgetStateProperty.all(6),
                thumbVisibility: WidgetStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 50,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        );
      }),
    );
  }
}

class DropdownButtonTrigger extends GetView<VoltRentController> {
  const DropdownButtonTrigger({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lokasi",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppPallete.blackGrayColor,
              ),
        ),
        Row(
          children: [
            Obx(() {
              return Text(
                controller.selectedLocation.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Iconsax.arrow_down_1_copy,
              size: 15,
            ),
          ],
        ),
      ],
    );
  }
}
