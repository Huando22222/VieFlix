import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';

class CarouseWidget extends StatelessWidget {
  final List<CardEntity> data;
  const CarouseWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
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
              child: InkWell(
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
                  fit: BoxFit.fitHeight,
                  width: 1000.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
