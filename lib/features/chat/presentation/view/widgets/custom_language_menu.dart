import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';
import 'package:unheard_voices/core/widgets/text_to_speech.dart';

class CustomLanguageMenu extends StatefulWidget {
  const CustomLanguageMenu({Key? key}) : super(key: key);

  @override
  _CustomLanguageMenuState createState() => _CustomLanguageMenuState();
}

class _CustomLanguageMenuState extends State<CustomLanguageMenu> {
  late AppCubit appCubit;

  @override
  void initState() {
    super.initState();
    appCubit = AppCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.language,
        color: whiteColor,
      ),
      initialValue: appCubit.mainLange,
      onSelected: (value) {
        setState(() {
          appCubit.mainLange = value;
          appCubit.detect_lang_TTS(value);
        });
      },
      itemBuilder: (context) => buildLanguageMenuItems(appCubit),
    );
  }

  List<PopupMenuEntry<String>> buildLanguageMenuItems(AppCubit appCubit) {
    return [
      buildLanguageMenuItem(appCubit, "ar", "Arabic", "flag2.png"),
      buildLanguageMenuItem(appCubit, "en", "English", "flag1.png"),
      buildLanguageMenuItem(appCubit, "fr", "French", "flag3.png"),
    ];
  }

  PopupMenuItem<String> buildLanguageMenuItem(
    AppCubit appCubit,
    String value,
    String language,
    String flagImage,
  ) {
    return PopupMenuItem(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            language,
            style: TextStyle(
                color:
                    appCubit.mainLange == value ? Colors.grey : purpleBlueColor,
                fontWeight:
                    appCubit.mainLange == value ? FontWeight.bold : null,
                fontSize: 13),
          ),
          Image.asset(
            "assets/Images/$flagImage",
            width: 17,
          ),
        ],
      ),
    );
  }
}
