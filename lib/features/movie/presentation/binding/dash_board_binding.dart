import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/dash_board_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashBoardController());
  }
}
