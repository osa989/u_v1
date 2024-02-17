import 'package:flutter/material.dart';

class SlidingImage extends StatelessWidget {
  const SlidingImage({
    super.key,
    required this.slidingImageAnimation,
  });

  final Animation<Offset> slidingImageAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingImageAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingImageAnimation,
          child: Image.asset("assets/Images/logo6.png"),
        );
      },
    );
  }
}
