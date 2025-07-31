import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../routes/route.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({
    super.key,
    required SidebarXController controller,
    required this.scaffoldKey,
  }) : _controller = controller;

  final SidebarXController _controller;

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        width: Get.width,
        padding: EdgeInsets.zero,
      ),
      headerBuilder: (context, value) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      scaffoldKey.currentState!.closeEndDrawer();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  Text(
                    dotenv.env['APP_NAME']!,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Transform.translate(
                        offset: const Offset(10, 0),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(Assets.voltAir),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-30.0, 0.0),
                        child: Container(
                          width: 140,
                          height: 110,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(Assets.avatarBorder),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Transform.translate(
                      offset: const Offset(-40, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FirebaseAuth.instance.currentUser?.displayName ??
                                'Anonymous',
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          Text('Surabaya, Jawa Timur',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 32.0, left: 16.0),
                decoration: BoxDecoration(
                  gradient: AppPallete.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.crown,
                      color: AppPallete.whiteColor,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exclusive',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 240,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppPallete.grayColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Container(
                                width: 220 * 0.4,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppPallete.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Level 34',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppPallete.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                '44180 POINTS TO GO',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppPallete.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
      footerBuilder: (context, value) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Get.defaultDialog(
                title: "Konfirmasi Logout",
                middleText: "Apakah Anda yakin ingin logout?",
                backgroundColor: Colors.white,
                titleStyle: TextStyle(color: Colors.black),
                middleTextStyle: TextStyle(color: Colors.black),
                textConfirm: "Ya",
                textCancel: "Tidak",
                confirmTextColor: Colors.white,
                cancelTextColor: Colors.black,
                buttonColor: Colors.red,
                onConfirm: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAllNamed(RouteName.login);
                },
                onCancel: () {
                },
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.logout_copy),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        );
      },
      showToggleButton: false,
    );
  }
}
