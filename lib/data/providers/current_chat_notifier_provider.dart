import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:anyamar/data/models/chat/chat_model.dart';

part 'current_chat_notifier_provider.g.dart';

@riverpod
class CurrentChatNotifier extends _$CurrentChatNotifier {
  @override
  Chat? build() {
    return null;
  }

  void fetchCurrentChat(Chat chat) {
    state = chat;
  }

  void clearChat() {
    state = null;
  }
}
