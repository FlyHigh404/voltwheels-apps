
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'background_image.dart';
import 'content_container.dart';

class OnboardingWidget extends GetView<OnboardingController> {
  const OnboardingWidget({
    super.key,
    this.title,
    this.description,
    this.label,
    this.image,
    required this.index,
  });

  final int index;
  final String? title;
  final String? description;
  final String? label;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: image,
        ),
        ContentContainer(
          index: index,
          title: title,
          description: description,
          label: label,
        ),
      ],
    );
  }
}
