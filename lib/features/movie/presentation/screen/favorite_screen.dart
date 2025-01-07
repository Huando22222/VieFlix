import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/card_horiziontal_widget.dart';
import 'package:vie_flix/features/user/presentation/controller/favorite_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();

    return Column(
      children: [
        AppBar(
          title: Text(
            "Favorites",
          ),
          automaticallyImplyLeading: false,
        ),
        Obx(
          () {
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        CustomSlidableAction(
                          flex: 1,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          onPressed: (context) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Xác nhận xóa'),
                                  content: const Text(
                                      'Bạn có chắc muốn xóa mục này khỏi danh sách ?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Hủy'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        favoriteController.addOrRemoveFavorite(
                                            favoriteController
                                                .favorites[index]);
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Đã xóa khỏi danh sách yêu thích')),
                                        );
                                      },
                                      child: const Text('Xóa'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, size: 24),
                              SizedBox(height: 4),
                              Text(
                                'Xóa',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        CustomSlidableAction(
                          flex: 1,
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          onPressed: (context) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đã chia sẻ phim'),
                              ),
                            );
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share, size: 24),
                              SizedBox(height: 4),
                              Text(
                                'Chia sẻ',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    child: CardHoriziontalWidget(
                      slug: favoriteController.favorites[index].slug,
                      name: favoriteController.favorites[index].name,
                      originName:
                          favoriteController.favorites[index].originName,
                      source: favoriteController.favorites[index].source,
                      imagePath: favoriteController.favorites[index].imagePath,
                    ),
                  );
                },
                itemCount: favoriteController.favorites.length,
              ),
            );
          },
        )
      ],
    );
  }
}
