import 'package:flutter/material.dart';
import 'package:test_app/views/widgets/dashboard_widgets/chats_card_widget.dart';

class SingleChat extends StatelessWidget {
  const SingleChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatsCardWidget(isInChatPage: true);
  }
}
