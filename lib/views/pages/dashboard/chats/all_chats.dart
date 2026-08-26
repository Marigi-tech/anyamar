import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/models/chat/chat_model.dart';
import 'package:anyamar/data/models/chat/chat_user.dart';
import 'package:anyamar/data/providers/chat_provider.dart';
import 'package:anyamar/data/providers/current_chat_notifier_provider.dart';

class AllChats extends ConsumerWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatsProvider);
    final currentChat = ref.watch(currentChatProvider);
    final List<Color> avatarBackgroundColors = [
      AppColorsConstant.darkYellowColor,
      AppColorsConstant.redColor,
      AppColorsConstant.darkBlueColor,
      AppColorsConstant.darkGreenColor,
    ];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: ListView.separated(
              //todo: get user specific chats and messages
              itemCount: chats.length,
              shrinkWrap: true,
              separatorBuilder: (_, __) =>
                  const Divider(height: 12, thickness: 0.15),
              itemBuilder: (context, index) {
                final Chat chat = chats[index];
                final String userId = '001';

                // Get the first message to identify the participants
                final firstMessage = chat.chatMessages.first;

                // If I sent the message, the recipient is the 'receiver'
                // If I received it, the recipient is the 'sender'
                final ChatUser recipient = firstMessage.sender.userId == userId
                    ? firstMessage.receipient
                    : firstMessage.sender;

                return ListTile(
                  tileColor: currentChat == chat
                      ? AppColorsConstant.greenColor
                      : null,
                  leading: CircleAvatar(
                    radius: 18,
                    backgroundColor:
                        avatarBackgroundColors[index %
                            avatarBackgroundColors.length],
                    child: Text(
                      recipient.userName[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        color: AppColorsConstant.whiteColor,
                      ),
                    ),
                  ),
                  title: Text(
                    recipient.userName,
                    style: const TextStyle(fontSize: 14),
                  ),

                  onTap: () {
                    // ref.invalidate(currentChatProvider);
                    // ref.invalidate(chatMessagesProvider);
                    ref
                        .read(currentChatProvider.notifier)
                        .fetchCurrentChat(chat);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
