import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/feature_movie_controller.dart';

class FeatureMovieBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(FeatureMovieController());
  }
}
