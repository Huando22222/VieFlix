import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonMovieDetail extends StatelessWidget {
  const SkeletonMovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(child: const Placeholder());
  }
}
