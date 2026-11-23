import 'package:anyamar/commons/exports.dart';

class PropertyRecords extends ConsumerWidget {
  final Property property;
  final String introText;

  const PropertyRecords({
    super.key,
    required this.property,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);

    // Get rental income for this property.
    final rentRecords = appData.rentalRecords
        .where((record) => record.propertyId == property.propertyId)
        .map((record) {
          final rentEntry = record.rentEntry;

          final tenant = appData.tenants
              .where((tenant) => tenant.tenantId == rentEntry.tenantId)
              .singleOrNull;

          return FinancialRecord(
            datePaid: rentEntry.paymentDate,
            amountPaid: rentEntry.amountPaid,
            recordType: FinancialRecordTypes.rent,
            recordId: rentEntry.rentEntryId,
            propertyId: rentEntry.propertyId,
            paymentMethod: rentEntry.paymentMethod,
            paymentBy: Person(
              personName: tenant?.tenantName ?? '',
              personEmail: tenant?.tenantEmail ?? '',
              personPhone: tenant?.tenantPhoneNumber ?? '',
            ),
            recordNature: FinancialRecordNature.revenue,
          );
        });

    // Get expenses for this property.
    final expenses = appData.finances.where(
      (record) => record.propertyId == property.propertyId,
    );

    // Combine income and expenses.
    final financialRecords = [...rentRecords, ...expenses];

    return SingleChildScrollView(
      child: FinancesTable(
        introText: introText,
        isFromHomePage: false,
        financialRecords: financialRecords,
      ),
    );
  }
}
