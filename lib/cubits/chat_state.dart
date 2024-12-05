import 'package:gamer_tag_task/models/base_state.dart';
import 'package:gamer_tag_task/models/chat_model.dart';

class ChatState extends BaseState {
  const ChatState({
    super.status,
    required this.messages,
    required this.currentReceiver,
    this.showSendButton = false,
    this.animatingMessageId,
    this.isTimerEnabled = false,
  });

  final List<ChatModel> messages;
  final String currentReceiver;
  final bool showSendButton;
  final String? animatingMessageId;
  final bool isTimerEnabled;

  @override
  List<Object?> get props => [
        ...super.props,
        messages,
        showSendButton,
        currentReceiver,
        animatingMessageId,
        isTimerEnabled,
      ];

  ChatState copyWith({
    StateStatus? status,
    List<ChatModel>? messages,
    String? currentReceiver,
    bool? showSendButton,
    String? animatingMessageId,
    bool? isTimerEnabled,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      currentReceiver: currentReceiver ?? this.currentReceiver,
      showSendButton: showSendButton ?? this.showSendButton,
      animatingMessageId: animatingMessageId,
      isTimerEnabled: isTimerEnabled ?? this.isTimerEnabled,
    );
  }
}
