import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/data_sets/units.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/widgets/tables/units_table.dart';

class UnitInformationCardWidget extends StatelessWidget {
  final Property property;
  const UnitInformationCardWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    List<Unit> propertyUnits = units
        .where((element) => element.propertyId == property.propertyId)
        .toList();
    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return Container(
          width: Responsiveness.isDesktop(context)
              ? getSizeFromContext(context).width * .60
              : double.infinity,
          height: 400,

          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: UnitsTable(units: propertyUnits, hasCardHeader: true),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
