import 'dart:developer';

import 'package:get/get.dart';
import 'package:vie_flix/features/movie/domain/entity/category_entity.dart';
import 'package:vie_flix/features/user/data/data_sources/local/database_data_source.dart';

class FilterController extends GetxController {
  final dbSource = DatabaseDataSource.instance;

  RxList<CategoryEntity> fav = <CategoryEntity>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadCategory();
  }

  void _loadCategory() async {
    try {
      final List<CategoryEntity> categories =
          await dbSource.getSelectedCategories();

      fav.assignAll(categories);
    } catch (e, stackTrace) {
      log('Error loading categories: $e = $stackTrace');
    } finally {}
  }

  void updateCategory() async {
    log('fav length: ${fav.length}');
    for (var i = 0; i < fav.length; i++) {
      log(fav[i].slug);
    }
    await dbSource.updateMultipleCategories(fav.map((e) => e.slug).toList());
  }

  void test() async {
    final categories = await dbSource.getSelectedCategories();
    log('cate db: ${categories.length}');
    categories.map((e) => log(e.slug)).toList();
  }

  void onSelectFavorite(CategoryEntity item) {
    if (fav.contains(item)) {
      fav.remove(item);
    } else {
      fav.add(item);
    }
  }
}
