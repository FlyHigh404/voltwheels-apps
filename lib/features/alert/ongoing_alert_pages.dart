import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/alert/alert_gradient_button.dart';

class OngoingAlertPages extends StatelessWidget {
  const OngoingAlertPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pemberitahuan"),
        centerTitle: true,
        leading: const SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Mohon maaf",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Fitur masih dalam proses pengembanngan",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              AlertGradientButton(
                isActive: true,
                borderRadius: 10,
                text: "Kembali",
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
