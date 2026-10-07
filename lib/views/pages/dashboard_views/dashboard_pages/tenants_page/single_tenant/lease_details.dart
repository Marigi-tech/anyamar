import 'package:anyamar/commons/exports.dart';


class LeaseDetails extends StatelessWidget {
  final Tenant tenant;
  final Property property;
  final Unit unit;
  const LeaseDetails({
    super.key,
    required this.tenant,
    required this.property,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
        child: Column(
          children: [
           
          ],
        ),
      ),
    );
  }
}
