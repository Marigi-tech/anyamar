import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/data_sets/chat_messages.dart';
import 'package:test_app/data/models/chat_message_model.dart';
import 'package:test_app/data/models/date_format_model.dart';
import 'package:test_app/data/providers/chat_messages_provider.dart';
import 'package:test_app/data/providers/current_chat_notifier_provider.dart';
import 'package:test_app/views/pages/dashboard_pages/chats_page/chat_page_widgets.dart';
import 'package:test_app/views/reusable_widgets/image_widgets/whatsapp_background.dart';

class ChatsCardWidget extends ConsumerWidget {
  final bool? isInChatPage;

  const ChatsCardWidget({super.key, this.isInChatPage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String userId = '001';
    //Sorting all chat messages according to time
    //todo: get chats that include this user as either the sender or receiver
    List<ChatMessage> currentChatMessages =
        isInChatPage == true
              ? ref.watch(chatMessagesProvider).toList()
              : [...chatMessages]
          ..sort((a, b) => a.chatTime.compareTo(b.chatTime));
    final currentChat = ref.watch(currentChatProvider);

    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return Container(
          width: Responsiveness.isDesktop(context)
              ? getSizeFromContext(context).width * .50
              : double.infinity,
          height: 600,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  //Enter card title here
                  isInChatPage != true ? ChatCardIntro() : SizedBox(),
                  // Receipient's Name
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      // Get the first message to identify the participants
                      // final firstMessage = chat.chatMessages.first;

                      // // If I sent the message, the recipient is the 'receiver'
                      // // If I received it, the recipient is the 'sender'
                      // final ChatUser recipient = firstMessage.sender.userId == userId
                      //     ? firstMessage.receipient
                      //     : firstMessage.sender;
                      child: Text(
                        isInChatPage == true && currentChat != null
                            //todo: check if the current chat is empty
                            ? currentChat.chatMessages.first.receipient.userName
                            : '',
                        style: CustomTextStyles.cardDescriptionStyle,
                      ),
                    ),
                  ),
                  //Divider
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(thickness: 0.18, height: 10.0),
                  ),
                  SizedBox(height: 10.0),

                  // Scrollable Chats Section
                  Expanded(
                    child: currentChat == null
                        ? WhatsAppBackgroundImageWidget()
                        : ListView.separated(
                            itemCount: currentChatMessages.length,

                            separatorBuilder: (_, __) =>
                                const Divider(height: 12, thickness: 0.15),
                            itemBuilder: (context, index) {
                              final ChatMessage message =
                                  currentChatMessages[index];

                              final bool isSender =
                                  userId == message.sender.userId;
                              final bool showDateHeader = _shouldShowDateHeader(
                                currentChatMessages,
                                index,
                              );

                              return Column(
                                mainAxisAlignment: isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Sticky date thingy
                                  Visibility(
                                    visible: showDateHeader,
                                    child: ChatDayWidget(
                                      date: message.chatTime,
                                    ),
                                  ),

                                  //Actual chat bubble
                                  Align(
                                    alignment: isSender
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: ChatMessageBubble(
                                      isSender: isSender,
                                      message: message,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ================= DATE HEADER LOGIC =================
bool _shouldShowDateHeader(List<ChatMessage> messages, int index) {
  if (index == 0) return true;

  final current = messages[index];
  final previous = messages[index - 1];

  return !isSameDay(current.chatTime, previous.chatTime);
}
