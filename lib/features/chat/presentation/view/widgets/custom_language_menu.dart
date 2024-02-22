import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';
import 'package:unheard_voices/core/widgets/text_to_speech.dart';

class CustomLanguageMenue extends StatelessWidget {
  const CustomLanguageMenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var short = BlocProvider.of<AppCubit>(context);
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.language,
        color: whiteColor,
      ),

      initialValue: "English", // Set the default selected value
      onSelected: (value) {
        if (value == "English") {
          short.setLang(lang: "en_US", voice: "en-US");
          short.setDir(mainlang: "English");
          TextToSpeech.initTTs();
        } else if (value == "Arabic") {
          short.setLang(lang: "ar_EG", voice: "ar");
          short.setDir(mainlang: "Arabic");
        }
        print(
            " langoooooooooooooooo is ${WidgetsBinding.instance.platformDispatcher.locale.languageCode}");
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "English",
          child: Text(
            "English",
            style: TextStyle(
              color: short.mainLange == "English" ? Colors.grey : null,
              fontWeight: short.mainLange == "English" ? FontWeight.bold : null,
            ),
          ),
        ),
        PopupMenuItem(
          value: "Arabic",
          child: Text(
            "Arabic",
            style: TextStyle(
              color: short.mainLange == "Arabic" ? Colors.grey : null,
              fontWeight: short.mainLange == "Arabic" ? FontWeight.bold : null,
            ),
          ),
        ),
      ],
    );
  }
}
