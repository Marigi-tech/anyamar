import 'package:anyamar/commons/exports.dart';

class RentEntriesPageSummaryCards extends ConsumerWidget {
  const RentEntriesPageSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;
    final appData = ref.watch(appDataProvider);
    final totalIncome = appData.rentRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.rentEntry.amountPaid,
    );
    final payingTenants = appData.tenants
        .where(
          (tenant) => appData.rentRecords.any(
            (record) => record.tenantId == tenant.tenantId,
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
          icon: Icons.numbers,
          title: 'Total records',
          value: '${appData.rentRecords.length}',
          subtitle: 'Total Rental records recorded ',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 14,
        ),

        SummaryCard(
          icon: Icons.wallet,
          title: 'Total Income from Rent',
          value: formatMoneyWithCurrency(totalIncome, 'Ksh'),
          subtitle: 'Total Rental income collected',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          fontSize: 14,
        ),
        SummaryCard(
          icon: Icons.person,
          title: 'Paying Tenants',
          value: '${payingTenants.length}',
          subtitle: 'Rent collected from this many tenants',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {
            //Show a list of paying tenants
          },
          fontSize: 14,
        ),
      ],
    );
  }
}
