import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/series_movie_controller.dart';

class SeriesMovieBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SeriesMovieController());
  }
}
