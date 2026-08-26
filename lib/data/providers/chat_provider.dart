import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/data/data_sets/chats.dart';
import 'package:anyamar/data/models/chat/chat_model.dart';

final chatsProvider = Provider<List<Chat>>((ref) {
  return chats; // your existing chats list
});
