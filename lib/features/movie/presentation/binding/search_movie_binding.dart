import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/controller/search_movie_controller.dart';

class SearchMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchMovieController());
  }
}
