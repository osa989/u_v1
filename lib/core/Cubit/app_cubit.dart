import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:unheard_voices/core/Cubit/app_states.dart';
import 'package:unheard_voices/core/widgets/text_to_speech.dart';
import 'package:unheard_voices/features/chat/presentation/view/chat_screen.dart';
import 'package:unheard_voices/features/home/presentation/view/widgets/home_screen_body.dart';
import 'package:unheard_voices/features/learn/data/categories_data.dart';
import 'package:unheard_voices/features/learn/data/category_data_details.dart';
import 'package:unheard_voices/features/learn/presentation/view/learn_screen.dart';
import 'package:unheard_voices/features/settings/presentation/view/settings_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(NavigationBarInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  double radiusCameraButton = 21;
  bool recordButtonVisibility = true;
  double textFieldHeight = 45;
  var textEditingController = TextEditingController();

  String gifPrediction = '';

  late CameraController cameraController;
  Future<void>? _initialization;
  int frame = 0;

  bool cameraOpen = false;

  int currentIndex = 0;

  List<dynamic> chatList = [];

  final SpeechToText speechToText = SpeechToText();

  String takeMessage = '';

  double radius = 21;

  String? lang;

  List<Widget> screens = [
    const HomeScreenBody(),
    ChatScreen(),
    const LearnScreen(),
    const SettingsScreen(),
  ];

  Map<String, String> translateToArabic = {
    "TV": "تليفزيون",
    "after": "بعد",
    "airplane": "طائرة",
    "all": "الكل",
    "alligator": "تمساح",
    "animal": "حيوان",
    "another": "آخر",
    "any": "أي",
    "apple": "تفاحة",
    "arm": "ذراع",
    "aunt": "خالة",
    "awake": "مستيقظ",
    "backyard": "الفناء الخلفي",
    "bad": "سيء",
    "balloon": "بالون",
    "bath": "حمام",
    "because": "لأن",
    "bed": "سرير",
    "bedroom": "غرفة نوم",
    "bee": "نحلة",
    "before": "قبل",
    "beside": "بجانب",
    "better": "أفضل",
    "bird": "طائر",
    "black": "أسود",
    "blow": "نفخ",
    "blue": "أزرق",
    "boat": "قارب",
    "book": "كتاب",
    "boy": "ولد",
    "brother": "أخ",
    "brown": "بني",
    "bug": "حشرة",
    "bye": "وداعًا",
    "callonphone": "اتصال هاتفي",
    "can": "يمكن أن",
    "car": "سيارة",
    "carrot": "جزر",
    "cat": "قطة",
    "cereal": "حبوب الإفطار",
    "chair": "كرسي",
    "cheek": "خد",
    "child": "طفل",
    "chin": "ذقن",
    "chocolate": "شكولاتة",
    "clean": "نظيف",
    "close": "قريب",
    "closet": "خزانة",
    "cloud": "سحابة",
    "clown": "مهرج",
    "cow": "بقرة",
    "cowboy": "رعاة البقر",
    "cry": "يبكي",
    "cut": "يقطع",
    "cute": "لطيف",
    "dad": "أب",
    "dance": "يرقص",
    "dirty": "قذر",
    "dog": "كلب",
    "doll": "دمية",
    "donkey": "حمار",
    "down": "أسفل",
    "drawer": "درج",
    "drink": "يشرب",
    "drop": "يقطر",
    "dry": "جاف",
    "dryer": "مجفف",
    "duck": "بطة",
    "ear": "أذن",
    "elephant": "فيل",
    "empty": "فارغ",
    "every": "كل",
    "eye": "عين",
    "face": "وجه",
    "fall": "يسقط",
    "farm": "مزرعة",
    "fast": "سريع",
    "feet": "أقدام",
    "find": "يجد",
    "fine": "بخير",
    "finger": "إصبع",
    "finish": "ينتهي",
    "fireman": "رجل الإطفاء",
    "first": "أول",
    "fish": "سمكة",
    "flag": "علم",
    "flower": "زهرة",
    "food": "طعام",
    "for": "لأجل",
    "frenchfries": "بطاطس مقلية",
    "frog": "ضفدع",
    "garbage": "قمامة",
    "gift": "هدية",
    "giraffe": "زرافة",
    "girl": "فتاة",
    "give": "يعطي",
    "glasswindow": "زجاج",
    "go": "يذهب",
    "goose": "أوزة",
    "grandma": "جدة",
    "grandpa": "جد",
    "grass": "عشب",
    "green": "أخضر",
    "gum": "علكة",
    "hair": "شعر",
    "happy": "سعيد",
    "hat": "قبعة",
    "hate": "يكره",
    "have": "يملك",
    "haveto": "يجب",
    "head": "رأس",
    "hear": "يسمع",
    "helicopter": "طائرة هليكوبتر",
    "hello": "مرحبا",
    "hen": "دجاجة",
    "hesheit": "هو أو هي",
    "hide": "يختبئ",
    "high": "مرتفع",
    "home": "منزل",
    "horse": "حصان",
    "hot": "حار",
    "hungry": "جائع",
    "icecream": "بوظة",
    "if": "إذا",
    "into": "في",
    "jacket": "سترة",
    "jeans": "بنطلون جينز",
    "jump": "يقفز",
    "kiss": "يُقبّل",
    "kitty": "قطة صغيرة",
    "lamp": "مصباح",
    "later": "لاحقًا",
    "like": "يحب",
    "lion": "أسد",
    "lips": "شفاه",
    "listen": "يسمع",
    "look": "ينظر",
    "loud": "صاخب",
    "mad": "غاضب",
    "make": "يصنع",
    "man": "رجل",
    "many": "كثير",
    "milk": "حليب",
    "minemy": "مِلكي / مِلكيتي",
    "mitten": "قفاز إصابع",
    "mom": "أمي",
    "moon": "قمر",
    "morning": "صباح",
    "mouse": "فأر",
    "mouth": "فم",
    "nap": "غفوة",
    "napkin": "مناديل",
    "night": "ليلة",
    "no": "لا",
    "noisy": "مُزعج",
    "nose": "أنف",
    "not": "ليس",
    "now": "الآن",
    "nuts": "مكسرات",
    "old": "قديم",
    "on": "على",
    "open": "يفتح",
    "orange": "برتقال",
    "outside": "خارج",
    "owie": "آه",
    "owl": "بومة",
    "pajamas": "بيجامة",
    "pen": "قلم",
    "pencil": "قلم رصاص",
    "penny": "فئة بنس واحدة",
    "person": "شخص",
    "pig": "خنزير",
    "pizza": "بيتزا",
    "please": "من فضلك",
    "police": "شرطة",
    "pool": "حمام سباحة",
    "potty": "نونية",
    "pretend": "يتظاهر",
    "pretty": "جميل",
    "puppy": "جرو صغير",
    "puzzle": "لغز",
    "quiet": "هادئ",
    "radio": "راديو",
    "rain": "مطر",
    "read": "يقرأ",
    "red": "أحمر",
    "refrigerator": "ثلاجة",
    "ride": "يركب",
    "room": "غرفة",
    "sad": "حزين",
    "same": "نفسه",
    "say": "يقول",
    "scissors": "مقص",
    "see": "يرى",
    "shhh": "هس",
    "shirt": "قميص",
    "shoe": "حذاء",
    "shower": "دش",
    "sick": "مريض",
    "sleep": "ينام",
    "sleepy": "نعسان",
    "smile": "يبتسم",
    "snack": "وجبة خفيفة",
    "snow": "ثلج",
    "stairs": "درج",
    "stay": "يبقى",
    "sticky": "لزج",
    "store": "متجر",
    "story": "قصة",
    "stuck": "عالق",
    "sun": "شمس",
    "table": "طاولة",
    "talk": "يتحدث",
    "taste": "يتذوق",
    "thankyou": "شكرا",
    "that": "ذاك",
    "there": "هناك",
    "think": "يفكر",
    "thirsty": "عطشان",
    "tiger": "نمر",
    "time": "وقت",
    "tomorrow": "غدا",
    "tongue": "لسان",
    "tooth": "سن",
    "toothbrush": "فرشاة أسنان",
    "touch": "يلمس",
    "toy": "لعبة",
    "tree": "شجرة",
    "uncle": "عم",
    "underwear": "ملابس داخلية",
    "up": "فوق",
    "vacuum": "مكنسة كهربائية",
    "wait": "ينتظر",
    "wake": "يستيقظ",
    "water": "ماء",
    "wet": "مبلل",
    "weus": "نحن",
    "where": "أين",
    "white": "أبيض",
    "who": "من",
    "why": "لماذا",
    "will": "سوف",
    "wolf": "ذئب",
    "yellow": "أصفر",
    "yes": "نعم",
    "yesterday": "أمس",
    "yourself": "نفسك",
    "yucky": "مقرف",
    "zebra": "حمار وحشي",
    "zipper": "سحاب"
  };

  Map<String, String> translateToEnglish = {
    "تليفزيون": "TV",
    "بعد": "after",
    "طائرة": "airplane",
    "الكل": "all",
    "تمساح": "alligator",
    "حيوان": "animal",
    "آخر": "another",
    "أي": "any",
    "تفاحة": "apple",
    "ذراع": "arm",
    "خالة": "aunt",
    "مستيقظ": "awake",
    "الفناء الخلفي": "backyard",
    "سيء": "bad",
    "بالون": "balloon",
    "حمام": "bath",
    "لأن": "because",
    "سرير": "bed",
    "غرفة نوم": "bedroom",
    "نحلة": "bee",
    "قبل": "before",
    "بجانب": "beside",
    "أفضل": "better",
    "طائر": "bird",
    "أسود": "black",
    "نفخ": "blow",
    "أزرق": "blue",
    "قارب": "boat",
    "كتاب": "book",
    "ولد": "boy",
    "أخ": "brother",
    "بني": "brown",
    "حشرة": "bug",
    "وداعًا": "bye",
    "اتصال هاتفي": "callonphone",
    "يمكن": "can",
    "سيارة": "car",
    "جزر": "carrot",
    "قطة": "cat",
    "حبوب الإفطار": "cereal",
    "كرسي": "chair",
    "خد": "cheek",
    "طفل": "child",
    "ذقن": "chin",
    "شكولاتة": "chocolate",
    "نظيف": "clean",
    "قريب": "close",
    "خزانة": "closet",
    "سحابة": "cloud",
    "مهرج": "clown",
    "بقرة": "cow",
    "رعاة البقر": "cowboy",
    "يبكي": "cry",
    "يقطع": "cut",
    "لطيف": "cute",
    "أب": "dad",
    "يرقص": "dance",
    "قذر": "dirty",
    "كلب": "dog",
    "دمية": "doll",
    "حمار": "donkey",
    "أسفل": "down",
    "درج": "drawer",
    "يشرب": "drink",
    "يقطر": "drop",
    "جاف": "dry",
    "مجفف": "dryer",
    "بطة": "duck",
    "أذن": "ear",
    "فيل": "elephant",
    "فارغ": "empty",
    "كل": "every",
    "عين": "eye",
    "وجه": "face",
    "يسقط": "fall",
    "مزرعة": "farm",
    "سريع": "fast",
    "أقدام": "feet",
    "يجد": "find",
    "بخير": "fine",
    "إصبع": "finger",
    "ينتهي": "finish",
    "رجل الإطفاء": "fireman",
    "أول": "first",
    "سمكة": "fish",
    "علم": "flag",
    "زهرة": "flower",
    "طعام": "food",
    "لأجل": "for",
    "بطاطس مقلية": "frenchfries",
    "ضفدع": "frog",
    "قمامة": "garbage",
    "هدية": "gift",
    "زرافة": "giraffe",
    "فتاة": "girl",
    "يعطي": "give",
    "زجاج": "glasswindow",
    "يذهب": "go",
    "أوزة": "goose",
    "جدة": "grandma",
    "جد": "grandpa",
    "عشب": "grass",
    "أخضر": "green",
    "علكة": "gum",
    "شعر": "hair",
    "سعيد": "happy",
    "قبعة": "hat",
    "يكره": "hate",
    "يملك": "have",
    "يجب": "haveto",
    "رأس": "head",
    "يسمع": "hear",
    "طائرة هليكوبتر": "helicopter",
    "مرحبا": "hello",
    "دجاجة": "hen",
    "هو أو هي": "hesheit",
    "يختبئ": "hide",
    "مرتفع": "high",
    "منزل": "home",
    "حصان": "horse",
    "حار": "hot",
    "جائع": "hungry",
    "بوظة": "icecream",
    "إذا": "if",
    "في": "into",
    "سترة": "jacket",
    "بنطلون جينز": "jeans",
    "يقفز": "jump",
    "يُقبّل": "kiss",
    "قطة صغيرة": "kitty",
    "مصباح": "lamp",
    "لاحقًا": "later",
    "يحب": "like",
    "أسد": "lion",
    "شفاه": "lips",
    "يسمع": "listen",
    "ينظر": "look",
    "صاخب": "loud",
    "غاضب": "mad",
    "يصنع": "make",
    "رجل": "man",
    "كثير": "many",
    "حليب": "milk",
    "مِلكي / مِلكيتي": "minemy",
    "قفاز إصابع": "mitten",
    "أمي": "mom",
    "قمر": "moon",
    "صباح": "morning",
    "فأر": "mouse",
    "فم": "mouth",
    "غفوة": "nap",
    "مناديل": "napkin",
    "ليلة": "night",
    "لا": "no",
    "مُزعج": "noisy",
    "أنف": "nose",
    "ليس": "not",
    "الآن": "now",
    "مكسرات": "nuts",
    "قديم": "old",
    "على": "on",
    "يفتح": "open",
    "برتقال": "orange",
    "خارج": "outside",
    "آه": "owie",
    "بومة": "owl",
    "بيجامة": "pajamas",
    "قلم": "pen",
    "قلم رصاص": "pencil",
    "فئة بنس واحدة": "penny",
    "شخص": "person",
    "خنزير": "pig",
    "بيتزا": "pizza",
    "من فضلك": "please",
    "شرطة": "police",
    "حمام سباحة": "pool",
    "نونية": "potty",
    "يتظاهر": "pretend",
    "جميل": "pretty",
    "جرو صغير": "puppy",
    "لغز": "puzzle",
    "هادئ": "quiet",
    "راديو": "radio",
    "مطر": "rain",
    "يقرأ": "read",
    "أحمر": "red",
    "ثلاجة": "refrigerator",
    "يركب": "ride",
    "غرفة": "room",
    "حزين": "sad",
    "نفسه": "same",
    "يقول": "say",
    "مقص": "scissors",
    "يرى": "see",
    "هس": "shhh",
    "قميص": "shirt",
    "حذاء": "shoe",
    "دش": "shower",
    "مريض": "sick",
    "ينام": "sleep",
    "نعسان": "sleepy",
    "يبتسم": "smile",
    "وجبة خفيفة": "snack",
    "ثلج": "snow",
    "درج": "stairs",
    "يبقى": "stay",
    "لزج": "sticky",
    "متجر": "store",
    "قصة": "story",
    "عالق": "stuck",
    "شمس": "sun",
    "طاولة": "table",
    "يتحدث": "talk",
    "يتذوق": "taste",
    "شكرا": "thankyou",
    "ذاك": "that",
    "هناك": "there",
    "يفكر": "think",
    "عطشان": "thirsty",
    "نمر": "tiger",
    "وقت": "time",
    "غدا": "tomorrow",
    "لسان": "tongue",
    "سن": "tooth",
    "فرشاة أسنان": "toothbrush",
    "يلمس": "touch",
    "لعبة": "toy",
    "شجرة": "tree",
    "عم": "uncle",
    "ملابس داخلية": "underwear",
    "فوق": "up",
    "مكنسة كهربائية": "vacuum",
    "ينتظر": "wait",
    "يستيقظ": "wake",
    "ماء": "water",
    "مبلل": "wet",
    "نحن": "weus",
    "أين": "where",
    "أبيض": "white",
    "من": "who",
    "لماذا": "why",
    "سوف": "will",
    "ذئب": "wolf",
    "أصفر": "yellow",
    "نعم": "yes",
    "أمس": "yesterday",
    "نفسك": "yourself",
    "مقرف": "yucky",
    "حمار وحشي": "zebra",
    "سحاب": "zipper"
  };

  void changeToOpenCamera() {
    cameraOpen = true;
    emit(OpenCameraStream());
  }

  void changeToCloseCamera() {
    cameraOpen = false;
    emit(CloseCameraStream());
  }

  void setSelectedValue(AppStates value) {
    emit(value);
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );

    await cameraController.initialize();

    final serverUrl = Uri.parse('http://192.168.43.161:3000/upload');
    //const Duration frameDelay = Duration(milliseconds: 2); // Adjust for 3 frames per second
    bool canSendFrame = true;

    if (cameraController.value.isInitialized) {
      await cameraController.startImageStream((CameraImage image) async {
        if (image.planes[0].bytes.isNotEmpty && canSendFrame) {
          canSendFrame = false; // Disable sending until the delay is complete
          frame += 1;
          print(frame);
          try {
            final response = await http.post(
              serverUrl,
              body: image.planes[0].bytes,
            );

            final data = jsonDecode(response.body);
            var prediction = data['message'];
            if (prediction.isNotEmpty && prediction != '') {
              prediction = translateToArabic[prediction.toLowerCase()] ??
                  'Translation not available';
              prediction += ' ';
              textEditingController.text += prediction;
              emit(PredictionWords());
            }
            print(response.statusCode);
          } catch (e) {
            // Handle error if needed
          }

          // Delay for one-third of a second before allowing the next frame to be sent
          //await Future.delayed(frameDelay);

          canSendFrame = true; // Enable sending for the next frame
        } else {
          // Handle empty frame if needed
        }
      });
    }
  }

  Future<void> learnCamera(
      {categoryDataIndex, categoryDataDetailsIndex}) async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );

    await cameraController.initialize();

    final serverUrl = Uri.parse('http://192.168.43.161:3000/upload');
    //const Duration frameDelay = Duration(milliseconds: 2); // Adjust for 3 frames per second
    bool canSendFrame = true;

    if (cameraController.value.isInitialized) {
      await cameraController.startImageStream((CameraImage image) async {
        if (image.planes[0].bytes.isNotEmpty && canSendFrame) {
          canSendFrame = false; // Disable sending until the delay is complete
          frame += 1;
          print(frame);
          try {
            final response = await http.post(
              serverUrl,
              body: image.planes[0].bytes,
            );

            final data = jsonDecode(response.body);
            var prediction = data['message'];
            if (prediction.isNotEmpty && prediction != '') {
              if (prediction ==
                  categoriesData[categoryDataIndex]
                      .categoryDataDetails[categoryDataDetailsIndex]
                      .categoriesName) {
                Fluttertoast.showToast(
                  msg: 'Correct Sign',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                cameraController.dispose();
                changeToCloseCamera();
              }
              // emit(PredictionWords());
            }
            print(response.statusCode);
          } catch (e) {
            // Handle error if needed
          }

          // Delay for one-third of a second before allowing the next frame to be sent
          //await Future.delayed(frameDelay);

          canSendFrame = true; // Enable sending for the next frame
        } else {
          // Handle empty frame if needed
        }
      });
    }
  }

  List<CategoriesData> categories = [
    CategoriesData('assets/Images/1.webp', 'Animals'),
    CategoriesData('assets/Images/5.jpg', 'Family'),
    CategoriesData('assets/Images/6.webp', 'colors'),
    CategoriesData('assets/Images/7.jpg', 'food'),
  ];

  List<CategoryDataDetails> categoriesData = [
    CategoryDataDetails(
      categoryDataDetails: [
        CategoriesData('assets/GIF/animal.gif', 'animal'),
        CategoriesData('assets/GIF/donkey.gif', 'donkey'),
        CategoriesData('assets/GIF/duck.gif', 'duck'),
        CategoriesData('assets/GIF/bee.gif', 'bee'),
        CategoriesData('assets/GIF/bird.gif', 'bird'),
        CategoriesData('assets/GIF/cat.gif', 'cat'),
        CategoriesData('assets/GIF/dog.gif', 'dog'),
        CategoriesData('assets/GIF/elephant.gif', 'elephant'),
        CategoriesData('assets/GIF/zebra.gif', 'zebra'),
        CategoriesData('assets/GIF/wolf.gif', 'wolf'),
        CategoriesData('assets/GIF/mouse.gif', 'mouse'),
        CategoriesData('assets/GIF/lion.gif', 'lion'),
        CategoriesData('assets/GIF/frog.gif', 'frog'),
        CategoriesData('assets/GIF/cow.gif', 'cow'),
        CategoriesData('assets/GIF/aunt.gif', 'aunt'),
      ],
    ),
    CategoryDataDetails(
      categoryDataDetails: [
        CategoriesData('assets/GIF/grandma.gif', 'grandma'),
        CategoriesData('assets/GIF/grandpa.gif', 'grandpa'),
        CategoriesData('assets/GIF/brother.gif', 'brother'),
        CategoriesData('assets/GIF/child.gif', 'child'),
        CategoriesData('assets/GIF/man.gif', 'man'),
        CategoriesData('assets/GIF/mom.gif', 'mom'),
        CategoriesData('assets/GIF/uncle.gif', 'uncle'),
      ],
    ),
    CategoryDataDetails(
      categoryDataDetails: [
        CategoriesData('assets/GIF/black.gif', 'black'),
        CategoriesData('assets/GIF/blue.gif', 'blue'),
        CategoriesData('assets/GIF/brown.gif', 'brown'),
        CategoriesData('assets/GIF/green.gif', 'green'),
        CategoriesData('assets/GIF/orange.gif', 'orange'),
        CategoriesData('assets/GIF/red.gif', 'red'),
        CategoriesData('assets/GIF/yellow.gif', 'yellow'),
      ],
    ),
    CategoryDataDetails(
      categoryDataDetails: [
        CategoriesData('assets/GIF/fish.gif', 'fish'),
      ],
    ),
  ];

  Future<void> startStreaming() async {}

  void changeIndex(int index) {
    currentIndex = index;
    emit(NavigationBarChangeState());
  }

  void addMessage(String message) {
    chatList.add(message);
    emit(AddElementChatList());
  }

  void removeMessage(int index) {
    chatList.removeAt(index);
    emit(RemoveElementChatList());
  }

  void startSpeak(int index) {
    TextToSpeech.speak(chatList.elementAt(index));
  }

  void takeVoice() async {
    radius = 30;
    var available = await speechToText.initialize();
    if (available) {
      speechToText.listen(
        onResult: (result) {
          takeMessage = result.recognizedWords;
        },
        localeId: lang, //'en_US' // 'ar_EG'
      );
      emit(StartSpeechToText());
    }
  }

  void stopVoice() async {
    radius = 21;
    if (takeMessage.isNotEmpty) {
      addMessage(takeMessage);
    }
    takeMessage = '';
    await speechToText.stop();
    emit(StopSpeechToText());
  }

  void updateTextFieldDesign() {
    radiusCameraButton = 32;
    recordButtonVisibility = false;
    textFieldHeight = 80;
    emit(UpdateTextFieldDesign());
  }

  void removeUpdateTextFieldDesign() {
    radiusCameraButton = 21;
    recordButtonVisibility = true;
    textFieldHeight = 45;
    emit(RemoveUpdateTextFieldDesign());
  }

  void addGif() {
    emit(AddGifPrediction());
  }
}
