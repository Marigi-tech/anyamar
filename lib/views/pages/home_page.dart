import 'package:flutter/material.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          HeroWidget(title: 'Welcome home'),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),

            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Basic card Title',
                      style: CustomTextStyles.cardTitleStyle,
                    ),
                    Text(
                      'Card information',
                      style: CustomTextStyles.cardDescriptionStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
