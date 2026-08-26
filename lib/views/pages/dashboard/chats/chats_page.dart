import 'package:flutter/material.dart';
import 'package:anyamar/views/pages/dashboard/chats/all_chats.dart';
import 'package:anyamar/views/pages/dashboard/chats/single_chat.dart';
import 'package:anyamar/views/reusable_widgets/buttons/card_button_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_widgets/intro_text_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraints.maxHeight is the full height available to TenantsPage.
        final double totalHeight = constraints.maxHeight;
        // The ratios are 1:8, totaling 9 parts (1 + 8).
        const int totalFlex = 9;
        final double unitHeight = totalHeight / totalFlex;

        final double headerHeight = unitHeight * 1; // 1/9th of the height
        final double tableHeight = unitHeight * 8; // 8/9ths of the height

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: headerHeight,
              child: IntroTextWidget(dashboardItem: 'Chats'),
            ),

            SizedBox(
              height: tableHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Add Chat button
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 200,
                        child: CardButtonWidget(buttonTitle: 'Add Chat'),
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //All chats
                        Expanded(flex: 1, child: AllChats()),
                        //Single chat
                        Expanded(flex: 3, child: SingleChat()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
