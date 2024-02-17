import 'package:flutter/material.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';

int itemIndex = 0;

class ChatWidget extends StatelessWidget {
  ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: AppCubit.get(context).chatList.length,
        itemBuilder: (context, index)
        {
          return Column(
            children:
            [
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 6.0,
                  vertical: 5.0,
                ),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 100.0,
                    minHeight: 50.0,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 1,
                      color: purpleBlueColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 4,
                      top: 2,
                      bottom: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 8,
                                  end: 8,
                                  top: 6,
                                  bottom: 20,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(229, 232, 232, 0.35),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      '${AppCubit.get(context).chatList[index]}',
                                      maxLines: 8,
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                              height: 18,
                              child: IconButton(
                                onPressed: ()
                                {
                                  AppCubit.get(context).removeMessage(index);
                                },
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: purpleBlueColor,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if(AppCubit.get(context).gifPrediction.isNotEmpty && index == itemIndex)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 14,
                              bottom: 14,
                            ),
                            child: Container(
                              height: 168,
                              width: 300,
                              clipBehavior: Clip.hardEdge,
                              decoration:BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    width: 1,
                                    color: purpleBlueColor
                                ),
                              ),
                              child: Image(
                                image: AssetImage('assets/GIF/${AppCubit.get(context).gifPrediction}.gif'),
                              ),
                            ),
                          ),
                        Row(
                          children:
                          [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: purpleBlueColor,
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white70,
                                child: SizedBox(
                                  width: 28,
                                  height: 18,
                                  child: IconButton(
                                    onPressed: ()
                                    {
                                      AppCubit.get(context).startSpeak(index);
                                    },
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.volume_up_outlined,
                                      color: purpleBlueColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: purpleBlueColor,
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white70,
                                child: SizedBox(
                                  width: 28,
                                  height: 18,
                                  child: IconButton(
                                    onPressed: ()
                                    {
                                      print(itemIndex);
                                      AppCubit.get(context).startSpeak(index);
                                    },
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.archive_outlined,
                                      color: purpleBlueColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: purpleBlueColor,
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white70,
                                child: SizedBox(
                                  width: 28,
                                  height: 18,
                                  child: IconButton(
                                    onPressed: () async
                                    {
                                      itemIndex = index;
                                      final sentence = AppCubit.get(context).chatList[index];
                                      List words = sentence.split(" ");
                                      for (final word in words)
                                      {
                                        if(word.isNotEmpty)
                                        {
                                          var englishPrediction = AppCubit.get(context).translateToEnglish[word.toLowerCase()] ?? 'Translation not available';
                                          AppCubit.get(context).gifPrediction = englishPrediction;
                                          AppCubit.get(context).addGif();
                                          await Future.delayed(const Duration(milliseconds: 2400)); // Adjust delay as needed
                                        }
                                      }

                                      AppCubit.get(context).gifPrediction = '';
                                      AppCubit.get(context).addGif();
                                    },
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.sign_language_outlined,
                                      color: purpleBlueColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
