import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';
import 'package:vie_flix/common/widget/loading_widget.dart';

import 'package:vie_flix/common/widget/scaffold_widget.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/movie/presentation/controller/more_movie_controller.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/build_list_wrap_card_widget.dart';

class MoreMovieScreen extends StatelessWidget {
  const MoreMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MoreMovieController moreMovieController =
        Get.find<MoreMovieController>();

    return Obx(
      () => ScaffoldWidget(
        title: moreMovieController.title,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [],
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent - 100) {
                  moreMovieController.loadMore();
                }
              }
              return false;
            },
            child: ScrollColumPaddingWidget(
              children: [
                BuildListWrapCardWidget(
                  list: moreMovieController.relatedMovie.value
                      .map(
                        (e) => CardEntity(
                          name: e.name,
                          originName: e.originName,
                          poster: e.posterUrl,
                          thumbnail: e.thumbUrl,
                          slug: e.slug,
                          source: e.source,
                        ),
                      )
                      .toList(),
                  isLoading: moreMovieController.isLoading.value,
                ),
                Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: moreMovieController.isLoadingMore.value
                      ? const Center(child: LoadingWidget())
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
