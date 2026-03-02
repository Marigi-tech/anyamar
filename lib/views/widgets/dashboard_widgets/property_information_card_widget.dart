import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/data_sets/properties.dart';

import 'package:test_app/views/widgets/tables/properties_table.dart';

class PropertyInformationCardWidget extends StatefulWidget {
  const PropertyInformationCardWidget({super.key});

  @override
  State<PropertyInformationCardWidget> createState() =>
      _PropertyInformationCardWidgetState();
}

class _PropertyInformationCardWidgetState
    extends State<PropertyInformationCardWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return Container(
          width: Responsiveness.isDesktop(context)
              ? getSizeFromContext(context).width * .50
              : double.infinity,
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child:
              // Scrollable Table Section
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: PropertiesTable(
                        myProperties: properties,
                        hasCardHeader: true,
                      ),
                    ),
                  ),
                ],
              ),
        );
      },
    );
  }
}
