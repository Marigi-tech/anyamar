import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';

class QuickRentEntryActions extends ConsumerWidget {
  final SingleRentEntry? rentEntry;
  const QuickRentEntryActions({super.key, this.rentEntry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isGeneralPage = rentEntry == null ? true : false;
    return QuickActionsWidget(
      children: [
        //Update Record
        // if (financialRecord != null || rentEntry != null)
        if (!isGeneralPage)
          QWidget(
            onPressedCallBack: () {
              //If rent Entry
              if (rentEntry != null) {
                ref
                    .read(financesPageProvider.notifier)
                    .updateRentEntryRecord(rentEntry!);
              }
            },
            //     // ref.read(tenantPageProvider.notifier).updateTenant(tenant!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'Update Record',
                  icon: CupertinoIcons.pencil,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (rentEntry != null) CardItemSeparator(),
        if (isGeneralPage)
          //Add Rent Entry
          QWidget(
            onPressedCallBack: () =>
                ref.read(financesPageProvider.notifier).addIncomeRecord(),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'Add Rent Entry',
                  icon: CupertinoIcons.add,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),
        //View Rental Income
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () =>
                ref.read(financesPageProvider.notifier).viewRentPerTenant(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Rent / Tenant',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),

        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () =>
                ref.read(financesPageProvider.notifier).financesTable(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View all financial records',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
      ],
    );
  }
}
