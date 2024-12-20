import 'package:flutter/material.dart';
import 'package:vie_flix/features/movie/domain/entity/card_entity.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/card_widget.dart';
import 'package:vie_flix/features/movie/presentation/screen/widget/ske_card_widget.dart';

class BuildListWiewCardWidget extends StatelessWidget {
  final List<CardEntity> list;
  final bool isLoading;

  const BuildListWiewCardWidget({
    super.key,
    required this.list,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: SkeCardWidget());
    }
    if (list.isNotEmpty) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CardWidget(
              data: CardEntity(
            name: list[index].name,
            originName: list[index].originName,
            urlImage: list[index].urlImage,
            slug: list[index].slug,
          ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 5);
        },
        itemCount: list.length,
      );
    } else {
      return const Center(child: Text('Server gặp sự cố '));
    }
  }
}
