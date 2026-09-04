import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/commons/constants.dart';
import 'package:anyamar/data/providers/theme_provider.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //App theme  Mode
              Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppColorsConstant.transparentColor,
                    width: 0.09,
                  ),
                  borderRadius: BorderRadius.circular(05),
                ),

                child: ListTile(
                  leading: Icon(
                    themeIsDark == true ? Icons.dark_mode : Icons.light_mode,

                    size: 16,
                    color: AppColorsConstant.blueGreyColor,
                  ),
                  title: Text(
                    'System Mode : ${themeIsDark ? 'Dark' : 'Light'}',
                    style: TextStyle(fontSize: 13),
                  ),
                  onTap: () =>
                      ref.read(themeIsDarkProvider.notifier).toggleTheme(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
