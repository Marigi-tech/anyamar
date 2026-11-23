import 'package:anyamar/commons/exports.dart';

class RentPerTenantSummaryCards extends ConsumerWidget {
  final Property? property;
  const RentPerTenantSummaryCards({super.key, this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context)
        ? 2
        : property == null
        ? 4
        : 3;
    final appData = ref.watch(userInformationProvider);
    //rent records
    final rentRecords = appData.rentalRecords;
    final totalRent = property != null
        ? rentRecords
              .map((rentRecord) => rentRecord.rentEntry)
              .where((r) => r.propertyId == property!.propertyId)
              .fold<double>(0, (sum, record) => sum + record.amountPaid)
        : rentRecords
              .map((rentRecord) => rentRecord.rentEntry)
              .fold<double>(0, (sum, record) => sum + record.amountPaid);
    //tenants in rent records
    final tenants = appData.tenants
        .where(
          (tenant) => rentRecords.any(
            (rentRecord) => rentRecord.tenantId == tenant.tenantId,
          ),
        )
        .toList();

    return PageDisplayCardsWidget(
      gridCount: gridCount,
      cards: [
        SummaryCard(
          icon: Icons.wallet,
          title: 'No of Records ',
          value: '${rentRecords.length}',
          subtitle: 'Number of  records',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          fontSize: 13,
        ),
        if (property == null)
          SummaryCard(
            icon: Icons.people,
            title: 'Tenants ',
            value: '${tenants.length}',
            subtitle: 'Number of tenants with recorded rent records.',
            iconCardColor: AppColors.sideBarColor,
            onPressedCallBack: () {},
            fontSize: 13,
          ),

        SummaryCard(
          icon: Icons.wallet,
          title: 'Total Rent',
          value: formatMoneyWithCurrency(totalRent, 'Ksh'),
          subtitle: 'Total rental income collected',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          fontSize: 13,
        ),
      ],
    );
  }
}
