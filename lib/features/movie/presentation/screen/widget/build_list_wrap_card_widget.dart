import 'package:flutter/material.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/card_widget.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/ske_card_widget.dart';

class BuildListWrapCardWidget extends StatelessWidget {
  final List<CardEntity> list;
  final bool isLoading;
  final int? itemCount;
  const BuildListWrapCardWidget({
    super.key,
    this.itemCount,
    required this.list,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (isLoading) {
      return const Center(child: SkeCardWidget());
    }
    if (list.isNotEmpty) {
      final displayCount = itemCount != null
          ? (itemCount! < list.length ? itemCount! : list.length)
          : list.length;

      return Center(
        child: Wrap(
          spacing: 8.0,
          runSpacing: 18.0,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,
          children: List.generate(
            displayCount,
            (index) => CardWidget(
              width: size.height * 0.2,
              data: CardEntity(
                name: list[index].name,
                originName: list[index].originName,
                urlImage: list[index].urlImage,
                slug: list[index].slug,
              ),
            ),
          ),
        ),
      );
    } else {
      return const Center(child: Text('Server gặp sự cố '));
    }
  }
}
