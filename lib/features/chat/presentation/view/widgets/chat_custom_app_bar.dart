import 'package:flutter/material.dart';
import 'package:unheard_voices/constants.dart';

class ChatCustomAppBar extends StatelessWidget {
  const ChatCustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: purpleBlueColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight:
                Radius.circular(20)), // Set your desired border radius here
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 8,
          start: 10,
          end: 10,
        ),
        child: Row(
          children: [
            const SizedBox(
              height: 75,
            ),
            const Icon(
              Icons.subject_outlined,
              color: whiteColor,
              size: 30,
            ),
            const SizedBox(
              width: 70,
            ),
            const Text(
              'Unheard Voices',
              style: TextStyle(
                color: whiteColor,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 46,
            ),

            PopupMenuButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.language,
                  color: whiteColor,
                  
                ),
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "en-Us",
                        child: Text("English"),
                      ),
                      const PopupMenuItem(
                        value: "ar-Eg",
                        child: Text("Arabic"),
                      ),
                    ])
          ],
        ),
      ),
    );
  }
}

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          child: Text('English'),
        ),
        const PopupMenuItem<String>(
          child: Text('Arabic'),
        ),
        // Add more languages as needed
      ],
      icon: const Icon(Icons.language),
    );
  }
}
