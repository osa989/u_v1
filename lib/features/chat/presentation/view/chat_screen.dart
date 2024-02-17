import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';
import 'package:unheard_voices/core/Cubit/app_states.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/chat_widget.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/chat_custom_app_bar.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/chat_text_field.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/stream_camera_widget.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/stream_camera_widget2.dart';


class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  bool isTyping = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          body: Column(
            children:
            [
              const ChatCustomAppBar(),
              AppCubit.get(context).cameraOpen  ? const StreamCameraWidget2() : ChatWidget(),
              if(isTyping) ...[
                const SpinKitThreeBounce(
                  color: Colors.grey,
                  size: 20,
                ),
              ],
              ChatTextField(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      }
    );
  }
}
