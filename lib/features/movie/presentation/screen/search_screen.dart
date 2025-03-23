import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/core/constant/constants.dart';
import 'package:vie_flix/features/movie/presentation/controller/search_movie_controller.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/card_horiziontal_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchMovieController searchMovieController =
        Get.find<SearchMovieController>();

    return GestureDetector(
      onTap: () {
        log("messa123ge");
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.app_registration_rounded),
                ),
              ],
              automaticallyImplyLeading: false,
              title: const Text('VieFlix'),
            ),

            Obx(
              () => TextField(
                autofocus: false,
                controller: searchMovieController.textController,
                focusNode: searchMovieController.focusNode,
                onChanged: searchMovieController.onChanged,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: searchMovieController.searchText.value.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: searchMovieController.clearSearch,
                        )
                      : null,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Obx(
            //   () {
            //     if (searchMovieController.isFocused.value &&
            //         searchMovieController.searchText.value.isEmpty) {
            //       return Wrap(
            //         runSpacing: 10,
            //         spacing: 10,
            //         children: [
            //           _buildHistorySearchItem(name: "name"),
            //           _buildHistorySearchItem(name: "name"),
            //           _buildHistorySearchItem(name: "name"),
            //           _buildHistorySearchItem(name: "name"),
            //           _buildHistorySearchItem(name: "name"),
            //         ],
            //       );
            //     } else {
            //       return Container();
            //     }
            //   },
            // ),
            Obx(
              () {
                if (searchMovieController.searchList.isNotEmpty) {
                  return Expanded(
                    child: ListView.separated(
                      cacheExtent: 9999,
                      itemBuilder: (context, index) {
                        final item = searchMovieController.searchList[index];
                        return CardHoriziontalWidget(
                          slug: item.slug,
                          name: item.name,
                          originName: item.originName,
                          source: item.source,
                          imagePath: item.source == "KK"
                              ? "${Constants.baseUrlPoster}${item.thumbUrl}"
                              : item.posterUrl,
                          episodeCurrent: item.episodeCurrent,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox.shrink();
                      },
                      itemCount: searchMovieController.searchList.length,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySearchItem({required String name}) {
    return GestureDetector(
      onTap: () {
        log("search $name");
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(name),
      ),
    );
  }
}
