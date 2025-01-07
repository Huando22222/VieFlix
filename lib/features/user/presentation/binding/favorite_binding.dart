import 'package:get/get.dart';
import 'package:vie_flix/features/user/presentation/controller/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController());
  }
}
