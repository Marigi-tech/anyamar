import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/tenant_page/tenant_page_notifier.dart';

class SinglePageQuickActionsWidget extends ConsumerWidget {
  final Tenant tenant;
  const SinglePageQuickActionsWidget({super.key, required this.tenant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QuickActionsWidget(
      children: [
        //Update Tenant
        QWidget(
          onPressedCallBack: () =>
              ref.read(tenantPageProvider.notifier).updateTenant(tenant),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                text: 'Update Tenant',
                icon: CupertinoIcons.pencil,
              ),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //Add rent Entry
        QWidget(
          onPressedCallBack: () =>
              ref.read(tenantPageProvider.notifier).addRentEntry(tenant),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add rent entry', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        // //Add incidence report
        // QWidget(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       RowTitleWidget(
        //         text: 'Add incidence report',
        //         icon: CupertinoIcons.add,
        //       ),
        //       Icon(CupertinoIcons.chevron_right, size: 15),
        //     ],
        //   ),
        // ),
        // CardItemSeparator(),
        //End lease
        QWidget(
          onPressedCallBack: () =>
              ref.read(tenantPageProvider.notifier).updateTenant(tenant),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'End lease', icon: CupertinoIcons.stop),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
      ],
    );
  }
}
