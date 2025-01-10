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
    final OverlayPortalController overlayPortalController =
        OverlayPortalController();
    final LayerLink layerLink = LayerLink();

    final SearchMovieController searchMovieController =
        Get.find<SearchMovieController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          AppBar(
            actions: [
              CompositedTransformTarget(
                link: layerLink,
                child: IconButton(
                  onPressed: () {
                    overlayPortalController.toggle();
                  },
                  icon: const Icon(Icons.app_registration_rounded),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
            title: const Text('VieFlix'),
          ),
          OverlayPortal(
            controller: overlayPortalController,
            overlayChildBuilder: (context) {
              return TapRegion(
                onTapOutside: (event) {
                  if (overlayPortalController.isShowing) {
                    overlayPortalController.hide();
                  }
                },
                child: Stack(
                  children: [
                    CompositedTransformFollower(
                      link: layerLink,
                      targetAnchor: Alignment.topRight,
                      followerAnchor: Alignment.topRight,
                      offset: const Offset(0, 50),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Liên quan nhất"),
                            Text("Mới nhất"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Obx(
            () => TextField(
              autofocus: false,
              controller: searchMovieController.textController,
              focusNode: searchMovieController.focusNode,
              onChanged: searchMovieController.onChanged,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchMovieController.searchText.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
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
          )
        ],
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
