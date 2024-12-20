import 'package:get/get.dart';
import 'package:vie_flix/common/controller/bottom_navigation_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationController());
  }
}
