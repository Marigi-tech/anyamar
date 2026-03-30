import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_app/views/pages/initial_pages/login_page/login_page.dart';
import 'package:test_app/views/pages/initial_pages/signup_page/sign_up_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  // Lottie animation
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      height: MediaQuery.of(context).size.height / 2,
                      child: Lottie.asset(
                        'assets/lotties/town.json',
                        fit: BoxFit.contain, // <-- removes height conflict
                      ),
                    ),
                  ),
                  // Intro texts + buttons
                  Expanded(
                    child: Column(
                      children: [
                        //? App Name
                        FittedBox(
                          child: Text(
                            'AnyaMar ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              letterSpacing: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        //? App tag
                        Text(
                          'Property management solutions',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        //? Short paragraph
                        Text(
                          'Lorem Ipsum blah blah blah blah blah',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 20),

                        //Intro Buttons
                        //? Get Started
                        FilledButton(
                          style: FilledButton.styleFrom(elevation: 10.0),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignUpPage()),
                            );
                          },
                          child: Text('Get started'),
                        ),
                        SizedBox(height: 10.0),
                        //? Log in
                        OutlinedButton(
                          style: FilledButton.styleFrom(elevation: 10.0),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => LoginPage()),
                            );
                          },
                          child: Text('Log In'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
