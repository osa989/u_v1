import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:unheard_voices/constants.dart';

import 'package:unheard_voices/features/home/presentation/view/home_screen.dart';
import 'package:unheard_voices/features/splash/presentation/view/widgets/sliding_image.dart';
import 'package:unheard_voices/features/splash/presentation/view/widgets/sliding_text.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with TickerProviderStateMixin {
  late AnimationController textAnimationController;
  late Animation<Offset> slidingTextAnimation;

  late AnimationController imageAnimationController;
  late Animation<Offset> slidingImageAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSlidingTextAnimation();
    initSlidingImageAnimation();

    navigateToHome();
  }

//make the controllers end and not taking any resources from the app
  @override
  void dispose() {
    super.dispose();
    imageAnimationController.dispose();
    textAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: purpleBlueColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlidingImage(slidingImageAnimation: slidingImageAnimation),
          const Gap(5),
          SlidingText(slidingAnimation: slidingTextAnimation),
          // const SizedBox(
          //   height: 4,
          // ),
        ],
      ),
    );
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() => const HomeView(),
      //     transition: Transition.fade, duration: kTransitionDuration);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  void initSlidingImageAnimation() {
    imageAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    slidingImageAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(imageAnimationController);
    imageAnimationController.forward();
  }

  void initSlidingTextAnimation() {
    textAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    slidingTextAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(textAnimationController);
    textAnimationController.forward();
  }
}
