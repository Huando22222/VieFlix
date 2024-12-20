import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/latest_movie_controller.dart';

class LatestMovieBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(LatestMovieController());
  }
}
