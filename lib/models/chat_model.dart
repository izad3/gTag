class ChatModel {
  const ChatModel({
    required this.id,
    required this.message,
    required this.receiver,
    required this.timestamp,
    this.readAt,
    this.isDeletable = false,
  });
  final String id;
  final String message;
  final String receiver;
  final DateTime timestamp;
  final DateTime? readAt;
  final bool isDeletable;

  ChatModel copyWith({
    String? id,
    String? message,
    String? receiver,
    DateTime? timestamp,
    DateTime? readAt,
    bool? isDeletable,
  }) {
    return ChatModel(
      id: id ?? this.id,
      message: message ?? this.message,
      receiver: receiver ?? this.receiver,
      timestamp: timestamp ?? this.timestamp,
      readAt: readAt ?? this.readAt,
      isDeletable: isDeletable ?? this.isDeletable,
    );
  }
}
