import 'package:flutter/cupertino.dart';
import 'package:test_app/data/constants/commons.dart';

class SettingsIconWidget extends StatefulWidget {
  const SettingsIconWidget({super.key});

  @override
  State<SettingsIconWidget> createState() => _SettingsIconWidgetState();
}

class _SettingsIconWidgetState extends State<SettingsIconWidget> {
  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.transparent;
    return IconButton(
      icon: const Icon(CupertinoIcons.gear),
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(6),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      //Open a pop up with a bunch of settings
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Settings', style: TextStyle(fontSize: 16)),
                  CloseButton(),
                ],
              ),
              content: Container(
                height: 90,
                padding: EdgeInsets.symmetric(horizontal: 05.0, vertical: 04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //App Brightness  Mode
                      Card(
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: borderColor, width: 0.09),
                          borderRadius: BorderRadius.circular(05),
                        ),

                        child: ListTile(
                          leading: Icon(
                            themeIsDarkNotifier.value == true
                                ? Icons.light_mode
                                : Icons.dark_mode,

                            size: 16,
                            color: AppColorsConstant.blueGreyColor,
                          ),
                          title: Text(
                            'System Mode : ${themeIsDarkNotifier.value ? 'Dark' : 'Light'}',
                            style: TextStyle(fontSize: 13),
                          ),
                          onTap: () => themeIsDarkNotifier.value =
                              !themeIsDarkNotifier.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
