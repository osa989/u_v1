import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unheard_voices/constants.dart';

// class CustomPageView extends StatefulWidget {
//   const CustomPageView({Key? key}) : super(key: key);

//   @override
//   _CustomPageViewState createState() => _CustomPageViewState();
// }

// class _CustomPageViewState extends State<CustomPageView> {
//   late PageController _pageController;
//   static const int _numPages = 3;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
//       if (_pageController.page! < _numPages - 1) {
//         _pageController.nextPage(
//           duration: Duration(milliseconds: 2500),
//           curve: Curves.easeInOut,
//         );
//       } else {
//         _timer.cancel(); // Stop auto-scrolling when reaching the last page
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: SizedBox(
//         width: double.infinity,
//         height: 200,
//         child: PageView.builder(
//           controller: _pageController,
//           itemCount: _numPages,
//           itemBuilder: (context, index) => buildPage(index),
//         ),
//       ),
//     );
//   }

//   Widget buildPage(int index) {
//     final List<String> imagePaths = [
//       "assets/Images/bk5.png",
//       "assets/Images/bk7.png",
//       "assets/Images/bk4.jpg",
//     ];

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Image.asset(
//         imagePaths[index],
//         fit: BoxFit.fill,
//       ),
//     );
//   }
// }

class CustomPageView extends StatefulWidget {
  const CustomPageView({super.key});

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

final List<String> imagePaths = [
  "assets/Images/bk5.png",
  "assets/Images/bk7.png",
  "assets/Images/bk4.jpg",
];
late List<Widget> _pages;

int _activePage = 0;

final PageController _pageController = PageController(initialPage: 0);

Timer? _timer;

class _CustomPageViewState extends State<CustomPageView> {
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        //checks if it is on the last image
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = List.generate(imagePaths.length,
        (index) => ImagePlaceholder(imagePath: imagePaths[index]));
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 4,
          child: PageView.builder(
              controller: _pageController,
              itemCount: imagePaths.length,
              onPageChanged: (value) {
                setState(() {
                  _activePage = value;
                });
              },
              itemBuilder: (context, index) {
                //return image widget
                return _pages[index];
              }),
        ),
        // code for page indicator
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                _pages.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateTo(index as double,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor:
                          _activePage == index ? purpleBlueColor : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key, this.imagePath});
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}
