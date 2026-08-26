import 'package:anyamar/views/pages/dashboard/properties_page/single_property/property_tabs/property_overview/overview_mobile.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/single_property/property_tabs/property_overview/overview_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/responsiveness/responsiveness.dart';

class PropertyOverview extends StatefulWidget {
  final Property property;
  const PropertyOverview({super.key, required this.property});

  @override
  State<PropertyOverview> createState() => _PropertyOverviewState();
}

class _PropertyOverviewState extends State<PropertyOverview> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsiveness.isMobile(context);
    return isMobile
        ? OverviewMobile(property: widget.property)
        : OverviewWeb(property: widget.property);
  }
}
