// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vie_flix/common/styles/app_color.dart';
import 'package:vie_flix/config/routes/app_route.dart';

class CardHoriziontalWidget extends StatelessWidget {
  final String slug;
  final String name;
  final String originName;
  final String source;
  final String imagePath;
  final String? episodeCurrent;
  const CardHoriziontalWidget({
    super.key,
    required this.slug,
    required this.name,
    required this.originName,
    required this.source,
    required this.imagePath,
    this.episodeCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoute.detailMovieScreen,
          arguments: {
            'slug': slug,
            'source': source,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
          color: source == "KK" ? AppColor.kkphim : AppColor.nguonC,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 150,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    originName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  if (episodeCurrent != null)
                    Text(
                      episodeCurrent!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
