import 'package:get/get.dart';

class BottomBarScaffoldController extends GetxController {
  final RxInt activeIndex = 0.obs;
  final RxBool setOpenDrawer = false.obs;

  void updateIndex(int value) {
    activeIndex.value = value;
  }

  void toogleDrawer() {
    setOpenDrawer.toggle();
  }
}
