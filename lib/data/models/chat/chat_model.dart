import 'package:anyamar/data/models/chat/chat_message_model.dart';

class Chat {
  final String chatId;
  final List<ChatMessage> chatMessages;
  final DateTime lastUpdated;

  Chat({
    required this.chatMessages,
    required this.chatId,
    required this.lastUpdated,
  });
}
