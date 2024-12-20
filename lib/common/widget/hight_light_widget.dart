// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HightLightWidget extends StatefulWidget {
//   final Widget child;

//   const HightLightWidget({
//     super.key,
//     required this.child,
//   });

//   @override
//   State<HightLightWidget> createState() => _HightLightWidgetState();
// }

// class _HightLightWidgetState extends State<HightLightWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Khởi tạo Animation Controller
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     // Tạo animation scale từ 0.8 đến 1.0
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.elasticOut,
//       ),
//     );

//     // Tạo animation opacity từ 0 đến 1
//     _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     // Chạy animation ngay khi widget được tạo
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background blur
//         Positioned.fill(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//             ),
//           ),
//         ),
//         // Centered overlay image with animation
//         Center(
//           child: FadeTransition(
//             opacity: _opacityAnimation,
//             child: ScaleTransition(
//               scale: _scaleAnimation,
//               child: TapRegion(
//                 onTapOutside: (event) {
//                   // Navigator.of(context).pop();
//                   Get.back();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         spreadRadius: 5,
//                         blurRadius: 10,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: widget.child,
//                   // child: Image.network(
//                   //   widget.imageUrl,
//                   //   width: 300,
//                   //   height: 450,
//                   //   fit: BoxFit.cover,
//                   // ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/material.dart';

class HightLightWidget extends StatefulWidget {
  final Widget child;
  final Widget childOverlay;

  const HightLightWidget({
    super.key,
    required this.child,
    required this.childOverlay,
  });

  @override
  State<HightLightWidget> createState() => _HightLightWidgetState();
}

class _HightLightWidgetState extends State<HightLightWidget>
    with SingleTickerProviderStateMixin {
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Khởi tạo Animation Controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Tạo animation scale từ 0.8 đến 1.0
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Tạo animation opacity từ 0 đến 1
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleOverlay() {
    if (_overlayPortalController.isShowing) {
      _overlayPortalController.toggle();
    } else {
      _overlayPortalController.toggle();
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayPortalController,
      overlayChildBuilder: (context) {
        return Stack(
          children: [
            // Background blur
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            // Centered overlay image with animation
            Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: TapRegion(
                    onTapOutside: (event) {
                      _overlayPortalController.toggle();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: widget.childOverlay,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: GestureDetector(
        onLongPress: () {
          _toggleOverlay();
        },
        child: widget.child,
      ),
    );
  }
}
