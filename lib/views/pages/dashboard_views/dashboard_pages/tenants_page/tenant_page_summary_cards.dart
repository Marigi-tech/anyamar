import 'package:anyamar/commons/exports.dart';

class TenantPageSummaryCards extends ConsumerWidget {
  const TenantPageSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 3;
    final appData = ref.watch(appDataProvider);
    final occupiedUnits = appData.units.where((u) => u.isOccupied).length;
    final vacantUnits = appData.units.where((u) => !u.isOccupied).length;
    final occupancyRate = occupiedUnits / appData.units.length;
    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.people,
          title: 'Total tenants',
          value: '${appData.tenants.length}',
          subtitle: 'All tenants',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.home_outlined,
          title: 'Occupied Units',
          value: '$occupiedUnits',
          subtitle: 'Across all properties',
          iconCardColor: AppColors.amber,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.apartment,
          title: 'Vacant Units',
          value: '$vacantUnits',
          subtitle: '${(occupancyRate * 100).toStringAsFixed(1)}% occupancy',
          iconCardColor: AppColors.red,
          onPressedCallBack: () {},
          fontSize: 17,
        ),
      ],
    );
  }
}

class SingleTenantPageSummaryCards extends ConsumerWidget {
  final Tenant tenant;
  const SingleTenantPageSummaryCards({super.key, required this.tenant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 3;
    final appData = ref.watch(appDataProvider);

    Unit currentUnit = appData.units
        .where((unit) => unit.unitId == tenant.unitId)
        .single;
    String propertyName = appData.properties
        .where((p) => p.propertyId == currentUnit.propertyId)
        .single
        .propertyName;
    double monthlyTotal = tenant.unitRent != null
        ? tenant.unitRent!.rentAmount +
              (tenant.unitRent?.utilities ?? []).fold<double>(
                0,
                (sum, utility) => sum + utility.amountPayable,
              )
        : currentUnit.unitRent!.rentAmount +
              (currentUnit.unitRent?.utilities ?? []).fold<double>(
                0,
                (sum, utility) => sum + utility.amountPayable,
              );
    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.house,
          title: 'Unit',
          value: currentUnit.unitName,
          subtitle: '${currentUnit.unitType!.label}, $propertyName',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.calendar_month,
          title: 'Move In Date',
          value: formatPrettyDate(tenant.startOfLease),
          subtitle: '',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.attach_money,
          title: 'Total / ${tenant.unitRent?.paymentFrequency}',
          value: formatMoneyWithCurrency(monthlyTotal, 'Ksh'),
          subtitle: '',
          iconCardColor: AppColors.red,
          onPressedCallBack: () {},
          fontSize: 17,
        ),
      ],
    );
  }
}
