import 'package:anyamar/commons/exports.dart';


class AddItemsWidget extends StatelessWidget {
  const AddItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              onButtonPressedCallBack: () => AddProperty(),
            ),
            const SizedBox(height: 15),
            // ==================================================
            // Add Tenant
            // ==================================================
            ElevatedButtonWidget(
              buttonTitle: 'Add Tenant',
              buttonIcon: Icon(Icons.add),
              buttonColor: AppColors.lightGreen,
              onButtonPressedCallBack: () => AddTenant(),
            ),
            const SizedBox(height: 15),
            // ==================================================
            // Add Unit
            // ==================================================
            ElevatedButtonWidget(
              buttonTitle: 'Add Unit',
              buttonIcon: Icon(Icons.add),
              buttonColor: AppColors.orange,
              onButtonPressedCallBack: () {},

              // onButtonPressedCallBack: () => AddUnit(),
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
              buttonTitle: 'Add Rental payment',
              buttonIcon: Icon(Icons.add),
              buttonColor: AppColors.lightGreen,
              onButtonPressedCallBack: () => AddRentalRecord(),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text('Close'),
        ),
      ],
    );
  }
}
