import 'package:anyamar/commons/exports.dart';

class QuickActionsPropertyWidget extends ConsumerWidget {
  final Property property;
  const QuickActionsPropertyWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QuickActionsWidget(
      children: [
        //Edit Property
        QWidget(
          onPressedCallBack: () => ref
              .read(propertyPageProvider.notifier)
              .showUpdateProperty(property),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                text: 'Update Property',
                icon: CupertinoIcons.pencil,
              ),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        QWidget(
          onPressedCallBack: () async {
            selectedWebPageNotifier.value = 2;
            selectedSideItemNotifier.value = 2;
            ref.read(unitPageProvider.notifier).showAddUnit(property: property);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add Unit', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),

        CardItemSeparator(),
        //Add Tenant
        QWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add Tenant', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //Add Expense report
        QWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add Expense', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
      ],
    );
  }
}
