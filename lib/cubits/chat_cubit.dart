import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag_task/cubits/chat_state.dart';
import 'package:gamer_tag_task/models/base_state.dart';
import 'package:gamer_tag_task/models/chat_model.dart';
import 'package:uuid/uuid.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(const ChatState(
            status: StateStatus.initial,
            currentReceiver: 'Max Payne',
            messages: [],
            animatingMessageId: null)) {
    messageController.addListener(showSendButton);
  }

  final int secondsToDelete = 10;
  final List<String> receivers = ['Max Payne', 'Mona Sax'];
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void showSendButton() {
    emit(state.copyWith(
        showSendButton: messageController.text.trimRight().isNotEmpty));
  }

  void addMessage() {
    var message = messageController.text;
    if (message.isEmpty) return;
    messageController.clear();
    final newMessageId = const Uuid().v4();
    if (state.isTimerEnabled) {
      Future.delayed(Duration(seconds: secondsToDelete), () {
        deleteMessage(newMessageId);
      });
    }

    emit(state.copyWith(
      messages: [
        ...state.messages,
        ChatModel(
          id: newMessageId,
          message: message.trimRight(),
          receiver: state.currentReceiver,
          timestamp: DateTime.now(),
          isDeletable: state.isTimerEnabled,
        )
      ],
      animatingMessageId: newMessageId,
      isTimerEnabled: false,
    ));

    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      emit(state.copyWith(
        animatingMessageId: null,
      ));
    });
  }

  void changeReceiver() {
    emit(
      state.copyWith(
        currentReceiver:
            receivers.firstWhere((e) => e != state.currentReceiver),
        messages: state.messages.map((e) {
          if (e.receiver != state.currentReceiver && e.readAt == null) {
            return e.copyWith(readAt: DateTime.now());
          }
          return e;
        }).toList(),
      ),
    );
  }

  void changeTimerState() {
    emit(state.copyWith(isTimerEnabled: !state.isTimerEnabled));
  }

  void deleteMessage(String id) {
    emit(
      state.copyWith(
          messages: state.messages.where((e) => e.id != id).toList()),
    );
  }
}
