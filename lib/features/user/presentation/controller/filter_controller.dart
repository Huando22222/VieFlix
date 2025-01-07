import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vie_flix/features/movie/domain/entity/category_entity.dart';
import 'package:vie_flix/features/user/data/data_sources/local/category_database_data_source.dart';
import 'dart:async';

class FilterController extends GetxController {
  final Completer<void> categoriesLoaded = Completer<void>();

  final CategoryDatabaseDataSource dbSource =
      GetIt.instance<CategoryDatabaseDataSource>();

  RxList<CategoryEntity> fav = <CategoryEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategory();
  }

  void _loadCategory() async {
    try {
      final List<CategoryEntity> categories =
          await dbSource.getSelectedCategories();
      fav.assignAll(categories);
      log("categories : ${categories.length}");
      categoriesLoaded.complete();
    } catch (e, stackTrace) {
      log('Error loading categories: $e = $stackTrace');
      categoriesLoaded.completeError(e);
    } finally {}
  }

  void updateCategory() async {
    for (var i = 0; i < fav.length; i++) {
      log(fav[i].slug);
    }
    await dbSource.updateMultipleCategories(fav.map((e) => e.slug).toList());
  }

  void onSelectFavorite(CategoryEntity item) {
    if (fav.contains(item)) {
      fav.remove(item);
    } else {
      fav.add(item);
    }
  }
}
