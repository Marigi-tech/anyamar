import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/unavailable_info/unavailable_info_model.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/page_states/property_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/page_states/tenant_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/page_states/unit_page_states.dart';

class AddItemsWidget extends ConsumerWidget {
  const AddItemsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Actions ',
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
                    .openForm(AddPropertyState(introText: 'dashboard'));
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
                    .openForm(AddTenantState(introText: 'dashboard'));
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
            //=========================================
            // Add Rental Payment
            // ==================================================
            ElevatedButtonWidget(
              buttonTitle: 'Add Rental record',
              buttonIcon: Icon(Icons.add),
              buttonColor: AppColors.purpleColor,
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
              buttonColor: AppColors.pinkColor,
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
            ElevatedButtonWidget(
              buttonTitle: 'Log Out',
              buttonColor: AppColors.red,
              buttonIcon: Icon(CupertinoIcons.power),

              onButtonPressedCallBack: () => showGeneralDialog(
                context: context,
                useRootNavigator: true,
                barrierDismissible: false,
                barrierLabel: 'Log Out',
                barrierColor: Colors.transparent,
                transitionDuration: const Duration(milliseconds: 250),

                pageBuilder: (dialogContext, animation, secondaryAnimation) {
                  return Material(
                    color: Colors.transparent,
                    child: InfoUnavailableOverlay(
                      isError: true,
                      unavailableInfo: UnavailableInfoModel(
                        text: 'Log Out',
                        supplementaryText:
                            ' Hello  ${appData.appUser?.userName} \n Are you sure you want to log out of your account ?',
                        closeMethod: () {
                          Navigator.of(
                            dialogContext,
                            rootNavigator: true,
                          ).pop();
                        },
                        ctaButtonWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButtonWidget(
                              isClear: true,
                              buttonTitle: 'Cancel',
                              onButtonPressedCallBack: () =>
                                  Navigator.pop(context),
                            ),
                            SizedBox(width: 06),
                            ElevatedButtonWidget(
                              buttonTitle: 'Log Out',
                              buttonColor: AppColors.red,
                              onButtonPressedCallBack: () async {
                                //dismiss initial pop up
                                await popContext(context);
                                //dismiss page provider (back to dashboard)
                                await ref
                                    .read(selectedPageProvider.notifier)
                                    .selectPage(0);

                                //Log out
                                await ref
                                    .read(authServiceProvider)
                                    .signOutUser();

                                //dismiss alert
                                Navigator.of(
                                  dialogContext,
                                  rootNavigator: true,
                                ).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                      child: const SizedBox.expand(),
                    ),
                  );
                },

                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
              ),
            ),
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
