// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';

class CarouseWidget extends StatelessWidget {
  final List<CardEntity> data;
  const CarouseWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final AppSettingController appSettingController =
        Get.find<AppSettingController>();
    return CarouselSlider(
      options: CarouselOptions(
        height: double.infinity,
        autoPlay: true,
        aspectRatio: 2.0,
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 10),
        scrollDirection: Axis.horizontal,
      ),
      items: List.generate(
        data.length,
        (index) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(
                        '${AppRoute.detailMovieScreen}/${data[index].slug}',
                        arguments: {
                          'source': data[index].source,
                        },
                      );
                    },
                    child: Image.network(
                      data[index].poster,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Obx(
                        () {
                          if (appSettingController.isShowTitleMovie.value) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  data[index].originName,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
