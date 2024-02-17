import 'package:flutter/material.dart';

class CustomLearningGroups extends StatelessWidget {
  const CustomLearningGroups({super.key});

  Widget learningGroup({
    // @required Color? color,
    // @required String? title,
    // @required String? subtitle,
    @required String? image,
  }) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.only(left: 20),
        height: 100,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          image!,
          fit: BoxFit.fill,
        )
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       title!,
        //       style: TextStyle(
        //         fontSize: 22,
        //         color: Colors.white70,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 5,
        //     ),
        //     Text(
        //       subtitle!,
        //       style: TextStyle(
        //         fontSize: 19,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            learningGroup(
              image: "assets/Images/2.jpg",
            ),
            learningGroup(
              image: "assets/Images/2.jpg",
            ),
            learningGroup(image: "assets/Images/2.jpg"),
            learningGroup(image: "assets/Images/2.jpg"),
          ],
        ),
      ),
    );
  }
}
