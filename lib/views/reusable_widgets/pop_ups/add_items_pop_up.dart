import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/page_states/property_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/page_states/tenant_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/page_states/unit_page_states.dart';

class AddItemsWidget extends ConsumerWidget {
  const AddItemsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'What do you wish to add ?',
            style: CustomTextStyles.cardDescriptionStyle.copyWith(fontSize: 15),
          ),
          CloseButton(),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ==================================================
            // Add Property
            // ==================================================
            ElevatedButtonWidget(
              buttonTitle: 'Add Property',
              buttonIcon: Icon(Icons.add),
              onButtonPressedCallBack: () async {
                await popContext(context);
                ref
                    .read(workspaceProvider.notifier)
                    .openForm(
                      AddPropertyState(introText: 'dashboard'),
                    );
              },
            ),
            const SizedBox(height: 15),
            // ==================================================
            // Add Tenant
            // ==================================================
            ElevatedButtonWidget(
              buttonTitle: 'Add Tenant',
              buttonIcon: Icon(Icons.add),
              buttonColor: AppColors.lightGreen,
              onButtonPressedCallBack: () async {
                await popContext(context);
                ref
                    .read(workspaceProvider.notifier)
                    .openForm(
                      AddTenantState(introText: 'dashboard'),
                    );
              },
            ),
            const SizedBox(height: 15),
            // ==================================================
            // Add Unit
            // ==================================================
            ElevatedButtonWidget(
              buttonTitle: 'Add Unit',
              buttonIcon: Icon(Icons.add),
              buttonColor: AppColors.orange,
              onButtonPressedCallBack: () async {
                await popContext(context);
                ref
                    .read(workspaceProvider.notifier)
                    .openForm(AddUnitState(introText: 'dashboard'));
              },
            ),
            const SizedBox(height: 15),
            // ==================================================
            // Add Payment
            // ==================================================
            // ElevatedButtonWidget(
            //   buttonTitle: 'Add Paymanent',
            //   buttonIcon: Icon(Icons.add),
            //   buttonColor: AppColors.red,
            //   onButtonPressedCallBack: () => AddExpenseRecord(),
            // ),
            const SizedBox(height: 15),
            // ==================================================
            // Add Rental Payment
            // ==================================================
            ElevatedButtonWidget(
              buttonTitle: 'Add Rental record',
              buttonIcon: Icon(Icons.add),
              buttonColor: AppColors.lightGreen,
              onButtonPressedCallBack: () async {
                await popContext(context);
                ref
                    .read(workspaceProvider.notifier)
                    .openForm(
                      DashboardPageStructure(
                        introText: 'dashboard / add rent record',
                        pageTitle: 'Add rent record',
                        introRowWidgets: [],
                        introButton: IntroButtonWidget(),
                        scrollableDashboardWidget: RentalRecordForm(),
                      ),
                    );
              },
            ),
            const SizedBox(height: 15),

            // ==================================================
            // Add Expense
            // ==================================================
            ElevatedButtonWidget(
              buttonTitle: 'Add Expense',
              buttonIcon: Icon(Icons.add),
              buttonColor: AppColors.orange,
              onButtonPressedCallBack: () async {
                await popContext(context);
                ref
                    .read(workspaceProvider.notifier)
                    .openForm(
                      DashboardPageStructure(
                        introText: 'dashboard / add expense record',
                        pageTitle: 'Add expense record',
                        introRowWidgets: [],
                        introButton: IntroButtonWidget(),
                        scrollableDashboardWidget: ExpenseRecordForm(),
                      ),
                    );
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            popContext(context);
          },

          child: const Text('Close'),
        ),
      ],
    );
  }

  Future<void> popContext(BuildContext dialogcontext) async {
    Navigator.pop(dialogcontext);
  }
}
