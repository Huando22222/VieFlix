import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/common/widget/Scroll_Colum_padding_widget.dart';
import 'package:vie_flix/features/movie/presentation/controller/search_movie_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OverlayPortalController overlayPortalController =
        OverlayPortalController();
    final LayerLink layerLink = LayerLink();

    final SearchMovieController controller = Get.find<SearchMovieController>();
    return ScrollColumPaddingWidget(
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
          title: Text('VieFlix'),
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
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          // bottomLeft: Radius.circular(8.0),
                        ),
                      ),
                      height: 50,
                      width: 200,
                    ),
                  ),
                ],
              ),
            );
          },
          // child: CompositedTransformTarget(
          //   link: _layerLink,
          //   child: IconButton(
          //     onPressed: () {
          //       _tooltipController.toggle();
          //     },
          //     icon: Icon(Icons.app_registration_rounded),
          //   ),
          // ),
        ),
        Obx(
          () => TextField(
            controller: controller.textController,
            focusNode: controller.focusNode,
            onChanged: controller.onChanged,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: controller.searchText.value.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: controller.clearSearch,
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
        ElevatedButton(
          onPressed: () {
            Drawer();
          },
          child: Text("Search"),
        ),
        const SizedBox(height: 10),
        Obx(
          () {
            if (controller.isFocused.value) {
              return Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  _buildHistorySearchItem(name: "name"),
                  _buildHistorySearchItem(name: "name"),
                  _buildHistorySearchItem(name: "name"),
                  _buildHistorySearchItem(name: "name"),
                  _buildHistorySearchItem(name: "name"),
                ],
              );
            } else {
              return Container();
            }
          },
        )
      ],
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
