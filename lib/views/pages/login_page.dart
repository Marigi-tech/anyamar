import 'package:flutter/material.dart';
import 'package:test_app/views/pages/widget_tree/widget_tree.dart';
import 'package:test_app/views/widgets/hero_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(
    text: 'email@email.com',
  );
  TextEditingController passwordController = TextEditingController(
    text: '1234',
  );
  String confirmedEmail = 'email@email.com';
  String confirmedPassword = '1234';
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              HeroWidget(title: widget.title),
              SizedBox(height: 20.0),
              //Enter form here
              //Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter email',
                ),
                onEditingComplete: () => setState(() {}),
              ),
              SizedBox(height: 10.0),
              //Password
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter password',
                ),
                onEditingComplete: () => setState(() {}),
              ),
              SizedBox(height: 20.0),
              //Button
              ElevatedButton(
                onPressed: () => onLogInPressed(),
                child: Text(widget.title),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLogInPressed() {
    if (confirmedEmail == emailController.text &&
        confirmedPassword == passwordController.text) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WidgetTree()),
      );
    }
  }
}
