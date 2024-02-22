import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';
import 'package:unheard_voices/core/Cubit/app_states.dart';

class CustomLanguageMenue extends StatelessWidget {
  const CustomLanguageMenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.language,
          color: whiteColor,
        ),
        onSelected: (value) {
          
          AppCubit().lang = value;
        },
        itemBuilder: (context) => [
              const PopupMenuItem(
                value: "en_US",
                child: Text("English"),
              ),
              const PopupMenuItem(
                value: "ar_Eg",
                child: Text("Arabic"),
              ),
            ]);
  }
}
