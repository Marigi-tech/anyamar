//Rent History Widget
import 'dart:developer';

import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/providers/rent_provider.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/rent_history/add_rent_record.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/single_tenant_intro.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/rent_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RentHistoryWidget extends ConsumerWidget {
  const RentHistoryWidget({
    super.key,
    required this.tenant,
    required this.tenantUnit,
  });
  final Tenant tenant;
  final Unit tenantUnit;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isMobile = Responsiveness.isMobile(context);
    final rentHistoryAsync = ref.watch(rentProvider(tenant.tenantId!));

    return Expanded(
      flex: isMobile ? 1 : 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: SingleTenantIntro(tenant: tenant, unit: tenantUnit),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rent payment history',
                style: CustomTextStyles.cardDescriptionStyle.copyWith(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                ),
              ),
              //Add rental record
              ColorButtonWidget(
                onPressedCallBack: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          AddRentalRecord(unit: tenantUnit, tenant: tenant),
                    ),
                  );
                },
                buttonTitle: 'Add Rental record',
                fontSize: 11,
                buttonColor: AppColorsConstant.greenColor,
              ),
            ],
          ),
          SizedBox(height: 20),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
              child: rentHistoryAsync.when(
                loading: () => const CircularProgressIndicator(),

                error: (error, stackTrace) {
                  return Text('Error loading rent history: $error');
                },

                data: (history) {
                  if (history == null) {
                    return const Text('No rent history');
                  }

                  final List<SingleRentEntry> rentEntries = history.rentEntries
                      .map((entry) => SingleRentEntry.fromJson(entry))
                      .toList();
                      log('Rent entries : $rentEntries');

                  return RentHistoryTable(rentEntries: rentEntries);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
