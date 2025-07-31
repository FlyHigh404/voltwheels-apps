import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:voltwheels_mobile/features/bottom_bar_scaffold/presentation/controllers/bottom_bar_scaffold_controller.dart';
import 'package:voltwheels_mobile/features/bottom_bar_scaffold/presentation/widgets/diamond_fab.dart';
import 'package:voltwheels_mobile/features/bottom_bar_scaffold/home/presentation/pages/home.dart';
import 'package:voltwheels_mobile/features/bottom_bar_scaffold/presentation/widgets/seach.dart';
import 'package:voltwheels_mobile/features/volt-rent/presentation/pages/volt_rent_orders_page.dart';
import '../widgets/sidebar_drawer.dart';

class BottomBarScaffold extends GetView<BottomBarScaffoldController> {
  const BottomBarScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final sidebarController =
        SidebarXController(selectedIndex: 0, extended: true);

    final List<Widget> pages = [
      HomePage(
        scaffoldKey: _scaffoldKey,
      ),
      const SearchPage(),
      const SearchPage(),
      const VoltRentOrdersPage(),
    ];

    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        endDrawer: SidebarDrawer(
          controller: sidebarController,
          scaffoldKey: _scaffoldKey,
        ),
        body: pages[controller.activeIndex.value],
        floatingActionButton: DiamondFAB(
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.activeIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            controller.activeIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Iconsax.home_1_copy),
                  SizedBox(
                    height: 4,
                  ),
                  Text('Home'),
                ],
              ),
              activeIcon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.home_1),
                  SizedBox(
                    height: 4,
                  ),
                  Text('Home'),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 35),
                child: Column(
                  children: [
                    Icon(Iconsax.search_normal_1_copy),
                    SizedBox(
                      height: 4,
                    ),
                    Text('Search'),
                  ],
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(right: 35),
                child: Column(
                  children: [
                    Icon(Iconsax.search_normal_1),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    Icon(Iconsax.message_notif_copy),
                    SizedBox(
                      height: 4,
                    ),
                    Text('Chat'),
                  ],
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    Icon(Iconsax.message_notif),
                    SizedBox(
                      height: 4,
                    ),
                    Text('Chat'),
                  ],
                ),
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Iconsax.receipt_2_1_copy),
                  SizedBox(
                    height: 4,
                  ),
                  Text('History'),
                ],
              ),
              activeIcon: Column(
                children: [
                  Icon(Iconsax.receipt_2_1),
                  SizedBox(
                    height: 4,
                  ),
                  Text('History'),
                ],
              ),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}
