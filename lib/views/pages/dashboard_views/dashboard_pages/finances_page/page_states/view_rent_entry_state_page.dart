import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/services/pdf_service.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/single_financial_record_page.dart';

class ViewRentEntryStatePage extends ConsumerWidget {
  final SingleRentEntry financialRecord;
  final String introText;
  const ViewRentEntryStatePage({
    super.key,
    required this.financialRecord,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    Tenant tenant = appData.tenants.firstWhere(
      (tenant) => tenant.tenantId == financialRecord.tenantId,
    );
    Unit unit = appData.units.firstWhere(
      (unit) => unit.unitId == financialRecord.unitId,
    );
    Property property = appData.properties.firstWhere(
      (property) => property.propertyId == property.propertyId,
    );

    // RentalMonth rentalMonth = appData.rentalRecords.where((record) => record.rentalMonths).contains(re)
    return DashboardPageStructure(
      introText: introText,
      pageTitle: 'Rent record ',
      supplementaryText: 'rent record : ${financialRecord.rentEntryId}',
      introButton: IntroButtonWidget(),
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Generate Receipt',
          buttonColor: AppColors.purpleColor,
          buttonIcon: Icon(Icons.receipt),
          onButtonPressedCallBack: () async {
            await PdfDocumentService.instance.generatePaymentReceipt(
              tenant: tenant,
              unit: unit,
              property: property,
              rentEntry: financialRecord,
            );
          },
        ),
      ],
      scrollableDashboardWidget: SingleFinancialRecordPage(
        rentEntry: financialRecord,
        introText: introText,
      ),
    );
  }
}
