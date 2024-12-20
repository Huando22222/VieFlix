import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/movie_detail_controller.dart';

class MovieDetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(MovieDetailController());
  }
}
