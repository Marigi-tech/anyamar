import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/data/models/chat_message_model.dart';
import 'package:test_app/data/providers/current_chat_notifier_provider.dart';

final chatMessagesProvider = Provider<List<ChatMessage>>((ref) {
  final currentChat = ref.watch(currentChatProvider);
  return currentChat == null ? [] : currentChat.chatMessages;
});
