import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();

  static initTTs() async {
    print(await tts.getLanguages);
    tts.setPitch(0.38);
    // tts.setLanguage(AppCubit().voice); //'en-US' // 'ar'
    tts.setSpeechRate(0.4);
  }

  static speak(String text) async {
    tts.setStartHandler(() {
      print('Text To Speech is started');
    });

    tts.setCompletionHandler(() {
      print('The text is speaking successfully');
    });

    tts.setErrorHandler((message) {
      print(message);
    });

    await tts.awaitSpeakCompletion(true);

    tts.speak(text);
  }
}
