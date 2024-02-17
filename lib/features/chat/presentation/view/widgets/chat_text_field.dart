import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/speech_to_text_widget.dart';

class ChatTextField extends StatelessWidget {
  ChatTextField({super.key});

  bool? isTyping;

  final SpeechToText speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
      [
        const SizedBox(
          width: 6,
        ),
        AvatarGlow(
          endRadius: AppCubit.get(context).radiusCameraButton,
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
              AppCubit.get(context).updateTextFieldDesign();
              AppCubit.get(context).changeToOpenCamera();
              await AppCubit.get(context).startStreaming();
            },
            onTapUp: (details){
              if(AppCubit.get(context).textEditingController.text.isEmpty){
                AppCubit.get(context).removeUpdateTextFieldDesign();
              }
              AppCubit.get(context).cameraController.dispose();
              AppCubit.get(context).changeToCloseCamera();
            },
            child: CircleAvatar(
                radius: AppCubit.get(context).radiusCameraButton,
                backgroundColor: purpleBlueColor,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
            ),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child:Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 12,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: AppCubit.get(context).textFieldHeight,
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.right,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    controller: AppCubit.get(context).textEditingController,
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      color: Color(0xF2808080),
                    ),
                    onSubmitted: (value)
                    {
                      if (AppCubit.get(context).textEditingController.text.isEmpty)
                      {
                        Fluttertoast.showToast(
                            //msg: "You can\'t send an empty message",
                            msg: "You can\'t send an empty message",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: purpleBlueColor,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                        AppCubit.get(context).addMessage(AppCubit.get(context).textEditingController.text);
                        AppCubit.get(context).removeUpdateTextFieldDesign();
                        AppCubit.get(context).textEditingController.clear();
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: (){},
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                      hintText: 'مرحبا كيف يمكنني مساعدتك؟',
                      border: InputBorder.none,
                      hintStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if(AppCubit.get(context).recordButtonVisibility)
          const SizedBox(
          width: 6,
        ),
        if(AppCubit.get(context).recordButtonVisibility)
          SpeechToTextWidget(),
        const SizedBox(
          width: 6,
        ),
      ],
    );
  }
}



