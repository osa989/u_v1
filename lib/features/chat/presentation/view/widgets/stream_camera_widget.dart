import 'dart:convert';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unheard_voices/constants.dart';

class CameraStreamWidget extends StatefulWidget {
  const CameraStreamWidget({super.key});

  @override
  _CameraStreamWidgetState createState() => _CameraStreamWidgetState();
}

class _CameraStreamWidgetState extends State<CameraStreamWidget> {
  late CameraController cameraController;
  //late StreamController<CameraImage> cameraStreamController;
  Future<void>? _initialization;
  bool isStreaming = false;
  String prediction = 'Waiting for prediction...';

  @override
  void initState() {
    super.initState();
    //cameraStreamController = StreamController<CameraImage>();
    _initialization = initializeCamera();
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


    if (mounted) {
      setState(() {});
    }
  }

  int frame = 0;

  Future<void> startStreaming() async {
    final serverUrl = Uri.parse('http://192.168.170.224:3000/upload');
    const Duration frameDelay = Duration(milliseconds: 333); // Adjust for 3 frames per second
    bool canSendFrame = true;

    if (cameraController.value.isInitialized) {
      setState(() {
        isStreaming = true;
      });

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

            setState(() {
              prediction = data['message'];
            });

            print(response.statusCode);
          } catch (e) {
            // Handle error if needed
          }

          // Delay for one-third of a second before allowing the next frame to be sent
          await Future.delayed(frameDelay);

          canSendFrame = true; // Enable sending for the next frame
        } else {
          // Handle empty frame if needed
        }
      });
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    // cancelImageStream();
    //cameraStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 8,
      ),
      child: Container(
        height: 560,
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
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (cameraController.value.isInitialized) {
                return Expanded(
                  child: AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController),
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
