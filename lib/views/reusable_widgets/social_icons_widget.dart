import 'package:flutter/material.dart';
import 'package:anyamar/commons/constants.dart';
import 'package:anyamar/views/reusable_widgets/buttons/social_icons_widget.dart';

class SocialIconsWidget extends StatelessWidget {
  const SocialIconsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // OR divider section
        Row(
          children: [
            Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR", style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Expanded(child: Divider(thickness: 1)),
          ],
        ),

        SizedBox(height: 18),

        // Row of social icons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: SocialIconButtonWidget(
                socialIcon: AppSocialIconConstant.googleIcon,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
