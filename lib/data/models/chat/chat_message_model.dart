import 'package:anyamar/data/models/chat/chat_user.dart';

class ChatMessage {
  final ChatUser sender;
  final ChatUser receipient;
  final String chatMessage;
  final DateTime chatTime;

  ChatMessage({
    required this.sender,
    required this.receipient,
    required this.chatMessage,
    required this.chatTime,
  });
}
