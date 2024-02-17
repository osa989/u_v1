import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/core/Cubit/app_cubit.dart';

class StreamCameraWidget2 extends StatelessWidget {
  const StreamCameraWidget2({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 8,
      ),
      child: Container(
        height: 532,
        width: 350,
        clipBehavior: Clip.hardEdge,
        decoration:BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              width: 1,
              color: purpleBlueColor
          ),
        ),
        child: FutureBuilder(
          future: AppCubit.get(context).initializeCamera(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (AppCubit.get(context).cameraController.value.isInitialized) {
                return Expanded(
                  child: AspectRatio(
                    aspectRatio: AppCubit.get(context).cameraController.value.aspectRatio,
                    child: CameraPreview(AppCubit.get(context).cameraController),
                  ),
                );
              } else {
                return const Text('Camera initialization failed');
              }
            } else {
              return const Center(child: CircularProgressIndicator(
                color: purpleBlueColor,
              ));
            }
          },
        ),
      ),
    );
  }
}
