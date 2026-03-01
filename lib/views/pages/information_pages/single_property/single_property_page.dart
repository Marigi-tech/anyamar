import 'package:flutter/material.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/views/pages/information_pages/single_property/property_tabs/property_tabs.dart';
import 'package:test_app/views/pages/information_pages/single_property/property_intro_card.dart';

class SinglePropertyPage extends StatelessWidget {
  final Property property;
  const SinglePropertyPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900, // controls page width
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                //Property Intro
                PropertyIntroCard(property: property),
                SizedBox(height: 10),
                Expanded(child: PropertyTabs(property: property)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
