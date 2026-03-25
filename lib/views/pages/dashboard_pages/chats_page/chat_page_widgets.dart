import 'package:bubble/bubble.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/models/chat_message_model.dart';
import 'package:test_app/data/models/date_format_model.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';

//Chat day Widget
class ChatDayWidget extends StatelessWidget {
  final DateTime date;
  const ChatDayWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
        child: Bubble(
          stick: true,
          color: const Color.fromRGBO(212, 234, 244, 1.0),
          child: Text(
            formatDayName(date),
            style: CustomTextStyles.cardDescriptionStyle.copyWith(
              color: AppColorsConstant.blackColor,
              fontSize: 11,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}

//Chat Message Bubble
class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isSender;
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    const styleReceiver = BubbleStyle(
      nip: BubbleNip.leftCenter,
      color: Colors.white,
      elevation: 4,
      margin: BubbleEdges.only(top: 8, right: 50),
      alignment: Alignment.topLeft,
    );

    const styleSender = BubbleStyle(
      nip: BubbleNip.rightCenter,
      color: AppColorsConstant.greenColor,
      elevation: 4,
      margin: BubbleEdges.only(top: 8, left: 50),
      alignment: Alignment.topRight,
    );
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.2,
      ),

      child: Bubble(
        style: isSender ? styleSender : styleReceiver,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: isSender
          //     ? MainAxisAlignment.end
          //     : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// MESSAGE TEXT
            Text(
              message.chatMessage,
              textAlign: isSender ? TextAlign.right : TextAlign.left,
              style: AppTextStylesConstant.cardDescriptionStyle.copyWith(
                color: isSender
                    ? AppColorsConstant.blackColor
                    : AppColorsConstant.blueGreyColor,
              ),
            ),

            const SizedBox(height: 6),

            /// TIME
            Align(
              alignment: Alignment.topRight,
              child: Text(
                formatJustTheTime(message.chatTime),
                style: CustomTextStyles.cardExtraDescriptionStyle.copyWith(
                  color: isSender
                      ? AppColorsConstant.blackColor
                      : AppColorsConstant.blueGreyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Chat Card Intro Title
class ChatCardIntro extends StatelessWidget {
  const ChatCardIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chats',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              //View button
              ColorButtonWidget(
                onPressedCallBack: () {
                  selectedWebPageNotifier.value = 4;
                },
                buttonTitle: 'View all',
                fontSize: 11,
                buttonColor: AppColorsConstant.greenColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
