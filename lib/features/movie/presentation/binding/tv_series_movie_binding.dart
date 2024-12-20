import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/tv_series_movie_controller.dart';

class TvSeriesMovieBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(TvSeriesMovieController());
  }
}
