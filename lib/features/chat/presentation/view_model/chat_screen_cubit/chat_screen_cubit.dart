import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unheard_voices/features/chat/presentation/view_model/chat_screen_cubit/chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState>
{
  ChatScreenCubit() : super(ChatScreenStateInitialState());

  static ChatScreenCubit get(context) => BlocProvider.of(context);


  List<String> chatList = [];
  int chatListIndex = 0;

  void chatScreen(String message)
  {
    chatListIndex ++;
    chatList[chatListIndex] = message;
    emit(AddElementChatList());
  }
}
