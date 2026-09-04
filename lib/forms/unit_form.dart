import 'package:anyamar/commons/exports.dart';


class AddUnit extends StatelessWidget {
  final Property? currentProperty;
  final Unit? currentUnit;
  final bool? isFromTenantPage;
  const AddUnit({super.key, this.currentProperty, this.currentUnit, this.isFromTenantPage});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(
      form: UnitForm(currentProperty: currentProperty, unit: currentUnit),
    );
  }
}
