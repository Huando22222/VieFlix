import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/animated_movie_controller.dart';

class AnimatedMovieBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AnimatedMovieController());
  }
}
