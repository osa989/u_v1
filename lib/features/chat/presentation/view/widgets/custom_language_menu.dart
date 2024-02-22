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
        BlocProvider.of<AppCubit>(context).lang = value;
      },
      initialValue: "ar_EG", // Set the default selected value
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "en_US",
          child: Text(
            "English",
            style: TextStyle(
              color: BlocProvider.of<AppCubit>(context).lang == "en_US"
                  ? Colors.grey
                  : null,
              fontWeight: BlocProvider.of<AppCubit>(context).lang == "en_US"
                  ? FontWeight.bold
                  : null,
            ),
          ),
        ),
        PopupMenuItem(
          value: "ar_EG",
          child: Text(
            "Arabic",
            style: TextStyle(
              color: BlocProvider.of<AppCubit>(context).lang == "ar_EG"
                  ? Colors.grey
                  : null,
              fontWeight: BlocProvider.of<AppCubit>(context).lang == "ar_EG"
                  ? FontWeight.bold
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
