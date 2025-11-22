import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
              onEditingComplete: () => setState(() {}),
            ),
            Text(controller.text),
            SizedBox(height: 10),
            CheckboxListTile(
              tristate: true, //Three states,true false or null
              title: Text('Select option'),
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),
            SwitchListTile.adaptive(
              title: Text('Switch'),
              value: isSwitched,
              onChanged: (value) => setState(() {
                isSwitched = value;
              }),
            ),
            Slider(
              max: 10.0,
              divisions: 10,
              value: sliderValue,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    content: Text('My snackbar'),
                  ),
                );
              },
              child: Text('Open snackbar'),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Divider(
                thickness: 2.0,
                color: Colors.teal,
                radius: BorderRadius.circular(20.0),
              ),
            ),
            FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Alert content'),
                    title: Text('Alert title'),
                    actions: [
                      OutlinedButton(onPressed: () {}, child: Text('Continue')),

                      CloseButton(),
                    ],
                  ),
                );
              },
              child: Text('Open dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
