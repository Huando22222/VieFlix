import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/domain/entity/favorite_entity.dart';
import 'package:vie_flix/features/user/data/data_sources/local/favorite_database_data_source.dart';

class FavoriteController extends GetxController {
  final FavoriteDatabaseDataSource dbSource =
      GetIt.instance<FavoriteDatabaseDataSource>();

  RxList<FavoriteEntity> favorites = <FavoriteEntity>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getFavorite();
    super.onInit();
  }

  Future<void> addOrRemoveFavorite(FavoriteEntity favorite) async {
    isLoading.value = true;
    if (favorites.contains(favorite)) {
      await dbSource.deleteFavorite(slug: favorite.slug);
      favorites.remove(favorite);
    } else {
      await dbSource.addFavorite(favorite: favorite);
      favorites.add(favorite);
    }
    // add boolean check later then fetch if true
    await getFavorite();
    isLoading.value = false;
  }

  Future<void> getFavorite() async {
    favorites.assignAll(await dbSource.getFavorites());
  }

  @override
  void onClose() {
    favorites.clear();
    super.onClose();
  }
}
