import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech
{
  static FlutterTts tts = FlutterTts();

  static initTTs() async
  {
    print(await tts.getLanguages);
    tts.setPitch(0.38);
    tts.setLanguage('en_US'); //'en_US' // 'ar'
    tts.setSpeechRate(0.4);
  }

  static speak(String text) async
  {
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