// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vie_flix/common/styles/app_color.dart';

import 'package:vie_flix/common/widget/hight_light_widget.dart';
import 'package:vie_flix/config/routes/app_route.dart';
import 'package:vie_flix/core/extension/text_extension.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/user/presentation/controller/app_setting_controller.dart';

class CardWidget extends StatelessWidget {
  final double? width;
  final CardEntity data;
  const CardWidget({
    super.key,
    this.width,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final AppSettingController appSettingController =
        Get.find<AppSettingController>();

    return HightLightWidget(
      childOverlay: Image.network(
        data.poster.fullImageUrl,
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
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRoute.detailMovieScreen,
            arguments: {
              'slug': data.slug,
              'source': data.source,
            },
          );
        },
        child: Obx(
          () {
            final isShowTitle = appSettingController.isShowTitleMovie.value;

            return SizedBox(
              width: width ??
                  (isShowTitle ? size.height * 0.15 : size.height * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height:
                        isShowTitle ? size.height * 0.2 : size.height * 0.25,
                    child: AspectRatio(
                      aspectRatio: 9 / 12,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: data.source == "KK"
                                ? AppColor.kkphim
                                : AppColor.nguonC,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignCenter,
                          ),
                        ),
                        child: Image.network(
                          data.poster.fullImageUrl,
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
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (isShowTitle)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          data.originName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
