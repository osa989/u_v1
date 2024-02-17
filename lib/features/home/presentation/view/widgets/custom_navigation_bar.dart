import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: purpleBlueColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight:
                Radius.circular(20)), // Set your desired border radius here
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        child: GNav(
          tabBorderRadius: 40,
          curve: Curves.easeInCirc,
          duration: const Duration(milliseconds: 500),
          gap: 8,
          color: Colors.white30,
          activeColor: whiteColor,
          iconSize: 24,
          tabBackgroundColor: Colors.white30,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          onTabChange: (index) {
            AppCubit.get(context).changeIndex(index);
          },
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
              iconSize: 22,
              textColor: whiteColor,
              iconColor: whiteColor,
            ),
            GButton(
              icon: Icons.message_outlined,
              text: 'Chat',
              iconSize: 22,
              textColor: whiteColor,
              iconColor: whiteColor,
            ),
            GButton(
              icon: Icons.school_outlined,
              text: 'Learn',
              iconSize: 22,
              textColor: whiteColor,
              iconColor: whiteColor,
            ),
            GButton(
              icon: Icons.settings,
              iconSize: 22,
              text: 'settings',
              textColor: whiteColor,
              iconColor: whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
