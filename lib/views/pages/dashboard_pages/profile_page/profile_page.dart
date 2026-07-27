import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/info_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColorsConstant.blueGreyColor,
              backgroundImage: AssetImage('assets/images/login.png'),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.person,
                    tileTitle: 'Name',
                    tileDescription: 'User Name ',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),

            //Email
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.envelope,
                    tileTitle: 'Email',
                    tileDescription: 'User email',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
            //Phone number
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.phone,
                    tileTitle: 'Phone',
                    tileDescription: 'User phone number',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
