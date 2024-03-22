import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:client/features/chat/models/chat_message_model.dart';
import 'package:client/features/chat/repos/chat_repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatNewPromptEvent>(chatNewPromptEvent);
    on<ChatNewContentGeneratedEvent>(chatNewContentGeneratedEvent);
  }

  StreamSubscription<http.Response>? _subscription;
  List<ChatMessageModel> cachedMessages = [];

  FutureOr<void> chatNewPromptEvent(
      ChatNewPromptEvent event, Emitter<ChatState> emit) {
    emit(ChatNewMessageGeneratingLoadingState());
    try {
      ChatMessageModel newMessage =
          ChatMessageModel(role: 'user', content: event.prompt);
      cachedMessages.add(newMessage);
      emit(ChatNewMessageGeneratedState());
      cachedMessages.add(ChatMessageModel(role: 'assistant', content: ""));
      _subscription?.cancel();
      _subscription = getChatGptResponseRepo(cachedMessages).listen((response) {
        for (String line in response.body.split('\n')) {
          String jsonDataString = line.replaceFirst("data: ", "");
          Map<String, dynamic> data = jsonDecode(jsonDataString.trim());

          add(ChatNewContentGeneratedEvent(content: data['data']));
        }
      });
    } catch (e) {
      log(e.toString());
      emit(ChatNewMessageGeneratingErrorState());
    }
  }

  FutureOr<void> chatNewContentGeneratedEvent(
      ChatNewContentGeneratedEvent event, Emitter<ChatState> emit) {
    ChatMessageModel modelMessage = cachedMessages.last;
    String content = event.content;
    cachedMessages.last = ChatMessageModel(
        role: 'assistant', content: modelMessage.content + content);
    log(cachedMessages.last.content);
    emit(ChatNewMessageGeneratedState());
  }
}
