import 'package:get/get.dart';
import 'package:vie_flix/features/user/presentation/controller/bottom_navigation_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationController());
  }
}