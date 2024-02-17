import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';

class SpeechToTextWidget extends StatelessWidget {
  SpeechToTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      endRadius: AppCubit.get(context).radius,
      animate: true,
      duration: const Duration(
        milliseconds: 2000,
      ),
      glowColor: purpleBlueColor,
      repeat: true,
      repeatPauseDuration: const Duration(
        milliseconds: 100,
      ),
      showTwoGlows: true,
      child: GestureDetector(
        onTapDown: (details) async{
          AppCubit.get(context).takeVoice();
        },
        onTapUp: (details) async {
          AppCubit.get(context).stopVoice();
        },
        child: CircleAvatar(
          backgroundColor: purpleBlueColor,
          radius: AppCubit.get(context).radius,
          child: const Icon(
            Icons.mic,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
