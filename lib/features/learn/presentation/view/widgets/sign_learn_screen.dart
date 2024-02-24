import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';
import 'package:unheard_voices/core/Cubit/app_states.dart';
import 'package:unheard_voices/features/chat/presentation/view/widgets/chat_custom_app_bar.dart';

class SignLearnScreen extends StatelessWidget {
  int index;
  int categoryIndex;
  SignLearnScreen(
      {required this.index, required this.categoryIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ChatCustomAppBar(),
                  AppCubit.get(context).cameraOpen
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 8,
                              ),
                              child: Container(
                                height: 480,
                                width: 350,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 1, color: purpleBlueColor),
                                ),
                                child: FutureBuilder(
                                  future: AppCubit.get(context).learnCamera(
                                      categoryDataIndex: categoryIndex,
                                      categoryDataDetailsIndex: index),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (AppCubit.get(context)
                                          .cameraController
                                          .value
                                          .isInitialized) {
                                        return Expanded(
                                          child: AspectRatio(
                                            aspectRatio: AppCubit.get(context)
                                                .cameraController
                                                .value
                                                .aspectRatio,
                                            child: CameraPreview(
                                                AppCubit.get(context)
                                                    .cameraController),
                                          ),
                                        );
                                      } else {
                                        return const Text(
                                            'Camera initialization failed');
                                      }
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                        color: purpleBlueColor,
                                      ));
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 58,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppCubit.get(context)
                                  .categoriesData[categoryIndex]
                                  .categoryDataDetails[index]
                                  .categoriesName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 8,
                                top: 20,
                                bottom: 14,
                              ),
                              child: Container(
                                height: 168,
                                width: 300,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    width: 1,
                                    color: purpleBlueColor,
                                  ),
                                ),
                                child: Image(
                                  image: AssetImage(AppCubit.get(context)
                                      .categoriesData[categoryIndex]
                                      .categoryDataDetails[index]
                                      .imageUrl),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 300,
                            ),
                          ],
                        ),
                  AvatarGlow(
                    endRadius: 50,
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
                      onTapDown: (details) async {
                        AppCubit.get(context).changeToOpenCamera();
                      },
                      onTapUp: (details) {
                        AppCubit.get(context).cameraController.dispose();
                        AppCubit.get(context).changeToCloseCamera();
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: purpleBlueColor,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
