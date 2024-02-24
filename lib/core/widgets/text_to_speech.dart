import 'package:flutter_tts/flutter_tts.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();

  static initTTs() async {
    print(await tts.getLanguages);
    tts.setPitch(0.38);

// OSAMA CODE START

        if (AppCubit().mainLange=="ar") {
        tts.setLanguage("ar");
        }else if(AppCubit().mainLange == "en"){
        tts.setLanguage("en-US");
        }else if(AppCubit().mainLange == "fr"){
        tts.setLanguage("fr-FR");
        }
 //'en-US' // 'ar'

 // OSAMA CODE END
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
