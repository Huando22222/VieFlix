import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeCardWidget extends StatelessWidget {
  const SkeCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Wrap(
        children: [
          Column(
            children: [
              SizedBox(
                height: 200,
                width: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/img2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text("name of the movie "),
            ],
          ),
          const SizedBox(width: 5),
          Column(
            children: [
              SizedBox(
                height: 200,
                width: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/img2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text("name of the movie "),
            ],
          ),
        ],
      ),
    );
  }
}
