import 'package:anyamar/commons/exports.dart';

class RentPerTenantSummaryCards extends ConsumerWidget {
  const RentPerTenantSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;
    final appData = ref.watch(appDataProvider);
    //rent records
    final rentRecords = appData.rentRecords;
    final totalRent = rentRecords
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

    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.wallet,
          title: 'No of Records ',
          value: '${rentRecords.length}',
          subtitle: 'Number of expense records',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.people,
          title: 'Tenants ',
          value: '${tenants.length}',
          subtitle: 'Number of tenants with recorded rent records.',
          iconCardColor: AppColors.sideBarColor,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.wallet,
          title: 'Total Rent',
          value: formatMoneyWithCurrency(totalRent, 'Ksh'),
          subtitle: 'Total rental income collected from tenants',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          fontSize: 17,
        ),
      ],
    );
  }
}
