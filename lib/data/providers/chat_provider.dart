import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/data/data_sets/chats.dart';
import 'package:test_app/data/models/chat_model.dart';

final chatsProvider = Provider<List<Chat>>((ref) {
  return chats; // your existing chats list
});
