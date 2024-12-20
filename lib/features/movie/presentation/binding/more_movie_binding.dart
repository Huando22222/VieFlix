import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/more_movie_controller.dart';

class MoreMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MoreMovieController());
  }
}
