import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unheard_voices/constants.dart';

class CustomAppSections extends StatelessWidget {
  const CustomAppSections({super.key});
  Widget services({@required Icon? icon, @required String? name}) {
    return Container(
      decoration: BoxDecoration(
          color: purpleBlueColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: icon,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            name!,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        childAspectRatio: 1.20,
        children: [
          services(
            icon: Icon(Icons.message_outlined, color: Colors.white),
            name: "Chat",
          ),
          services(
            icon: Icon(Icons.favorite_rounded, color: Colors.white),
            name: "Favorites",
          ),
          services(
            icon: Icon(
              FontAwesomeIcons.hands,
              color: Colors.white,
            ),
            name: "Learn",
          ),
        ],
      ),
    );
  }
}
