import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppStates
{

}

class NavigationBarInitialState extends AppStates {}

class NavigationBarChangeState extends AppStates {}

class AddElementChatList extends AppStates {}

class RemoveElementChatList extends AppStates {}

class StartSpeechToText extends AppStates {}

class StopSpeechToText extends AppStates {}

class InitialStateCamera extends AppStates {}

class PredictionStateCamera extends AppStates {}

class OpenCameraStream extends AppStates {}

class CloseCameraStream extends AppStates {}

class UpdateTextFieldDesign extends AppStates {}

class RemoveUpdateTextFieldDesign extends AppStates {}

class PredictionWords extends AppStates {}

class AddGifPrediction extends AppStates {}

class ChangeStateIndex extends AppStates {}





