// import 'package:flutter/material.dart';
// import 'package:test_app/views/pages/login_page.dart';
// import 'package:lottie/lottie.dart';

// class WelcomePage extends StatelessWidget {
//   const WelcomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Center(
//             child: FractionallySizedBox(
//               widthFactor: constraints.maxWidth > 500 ? 0.3 : 0.65,
//               child: SizedBox.expand(
//                 // <-- provides height constraints
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // TOP LOTTIE ANIMATION
//                     Expanded(
//                       flex: 1,
//                       child: Lottie.asset(
//                         'assets/lotties/town.json',
//                         fit: BoxFit.contain, // <-- removes height conflict
//                       ),
//                     ),

//                     // TEXT + BUTTONS SECTION
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FittedBox(
//                             child: Text(
//                               'AnyaMar ',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 40.0,
//                                 letterSpacing: 20.0,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             'Property management solutions',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             'Lorem Ipsum blah blah blah blah blah',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                           SizedBox(height: 20),

//                           // BUTTONS ROW
//                           SizedBox(
//                             height: 50,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: FilledButton(
//                                     style: FilledButton.styleFrom(
//                                       elevation: 10.0,
//                                     ),
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) =>
//                                               LoginPage(title: 'Register'),
//                                         ),
//                                       );
//                                     },
//                                     child: Text('Get started'),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Expanded(
//                                   child: TextButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) =>
//                                               LoginPage(title: 'Log In'),
//                                         ),
//                                       );
//                                     },
//                                     child: Text('Log In'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_app/views/pages/login_page.dart';

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
                              MaterialPageRoute(
                                builder: (_) => LoginPage(title: 'Register'),
                              ),
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
                              MaterialPageRoute(
                                builder: (_) => LoginPage(title: 'Log In'),
                              ),
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
