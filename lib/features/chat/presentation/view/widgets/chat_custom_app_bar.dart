import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/custom_language_menu.dart';

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
      child: const Padding(
        padding: EdgeInsetsDirectional.only(
          top: 10,
          start: 10,
          end: 10,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 75,
            ),
            Icon(
              Icons.subject_outlined,
              color: whiteColor,
              size: 30,
            ),
            SizedBox(
              width: 70,
            ),
            Text(
              'Unheard Voices',
              style: TextStyle(
                color: whiteColor,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 46,
            ),
            CustomLanguageMenue()
          ],
        ),
      ),
    );
  }
}
