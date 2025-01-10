import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonMovieDetail extends StatelessWidget {
  const SkeletonMovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final sz = MediaQuery.of(context).size;
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: sz.height * 0.25,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            color: Colors.grey.shade300,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 8),
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 30,
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 8),
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Spacer(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 8),
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 30,
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 8),
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 30,
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 8),
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          Container(
            height: 16,
            width: 150,
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.grey.shade300,
          ),
          Container(
            height: 14,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 6),
            color: Colors.grey.shade300,
          ),
          Container(
            height: 14,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 6),
            color: Colors.grey.shade300,
          ),
          Container(
            height: 14,
            width: 200,
            color: Colors.grey.shade300,
          ),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
