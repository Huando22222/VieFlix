import 'package:get/get.dart';
import 'package:vie_flix/features/user/presentation/controller/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(FilterController());
  }
}
