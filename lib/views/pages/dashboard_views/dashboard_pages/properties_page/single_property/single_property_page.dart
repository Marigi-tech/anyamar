import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_tabs.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_intro_card.dart';

class SinglePropertyPage extends StatelessWidget {
  final Property property;
  const SinglePropertyPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: Responsiveness.isDesktop(context)
          ? Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1100, // controls page width
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
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Property Intro
                  PropertyIntroCard(property: property),
                  SizedBox(height: 10),
                  Expanded(child: PropertyTabs(property: property)),
                ],
              ),
            ),
    );
  }
}
