
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/rent/rental_month/rental_month_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/providers/rent_provider.dart';
import 'package:anyamar/forms/add_rent_record_form.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/custom_data_table.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/rental_months_table.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RentHistoryWidget extends ConsumerStatefulWidget {
  final Tenant tenant;
  final Unit tenantUnit;

  const RentHistoryWidget({
    super.key,
    required this.tenant,
    required this.tenantUnit,
  });

  @override
  ConsumerState<RentHistoryWidget> createState() => _RentHistoryWidgetState();
}

class _RentHistoryWidgetState extends ConsumerState<RentHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    final tenantId = widget.tenant.tenantId;

    if (tenantId == null || tenantId.isEmpty) {
      return const Text('Tenant ID is missing');
    }

    final rentHistoryAsync = ref.watch(rentProvider(tenantId));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Rent History',
                style: CustomTextStyles.cardDescriptionStyle.copyWith(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  color: AppColorsConstant.darkBlueColor,
                  fontSize: 15.0,
                ),
              ),
            ),

            ColorButtonWidget(
              onPressedCallBack: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddRentalRecord(
                      unit: widget.tenantUnit,
                      tenant: widget.tenant,
                    ),
                  ),
                );
              },
              buttonTitle: 'Add Rental record',
              fontSize: 14,
              buttonColor: AppColorsConstant.greenColor,
            ),
          ],
        ),

        const SizedBox(height: 20),

        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
            child: rentHistoryAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),

              error: (error, stackTrace) {
                return Text('Error loading rent history: $error');
              },

              data: (history) {
                if (history == null) {
                  return const Text('No rent history');
                }

                // ==================================================
                // GET ALL ENTRIES FROM ALL RENTAL MONTHS
                // ==================================================

                final List<RentalMonth> rentalMonthEntries = history
                    .rentalMonths
                    .toList();

                // ==================================================
                // TABLE
                // ==================================================

                return CustomDataTable(
                  customDataColumns: [...buildRentalMonthColumns()],
                  customDataRows: [
                    ...rentalMonthEntries.asMap().entries.map((entry) {
                      final int index = entry.key;

                      final RentalMonth rentEntry = entry.value;

                      return buildRentalMonthDataRow(
                        index + 1,
                        context,
                        history,
                        rentEntry,
                        widget.tenantUnit,
                        widget.tenant,
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
