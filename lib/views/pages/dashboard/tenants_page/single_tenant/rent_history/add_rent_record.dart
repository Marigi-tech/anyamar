import 'dart:developer';
import 'package:anyamar/data/models/date_format/date_format_model.dart';
import 'package:anyamar/data/models/enums/financial_record_nature.dart';
import 'package:anyamar/data/models/enums/financial_record_types.dart';
import 'package:anyamar/data/models/enums/payment_methods_enum.dart';
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/month/month_model.dart';
import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/providers/rent_provider.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/data/services/db_rental_records.dart';
import 'package:anyamar/utils/loader/lazy_loader_util.dart';
import 'package:anyamar/utils/snackbar/snackbar_util.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_field_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/views/forms/dashboard_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:flutter/services.dart';

class AddRentalRecord extends StatelessWidget {
  final Unit unit;
  final Tenant tenant;
  const AddRentalRecord({super.key, required this.unit, required this.tenant});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(
      form: RentalRecordForm(tenant: tenant, unit: unit),
    );
  }
}

class RentalRecordForm extends ConsumerStatefulWidget {
  final Unit unit;
  final Tenant tenant;
  const RentalRecordForm({super.key, required this.unit, required this.tenant});

  @override
  ConsumerState<RentalRecordForm> createState() => _RentalRecordFormState();
}

class _RentalRecordFormState extends ConsumerState<RentalRecordForm> {
  TextEditingController amountController = TextEditingController();
  TextEditingController paymentDateController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  List<MonthModel> rentalMonths = [
    MonthModel(monthName: 'January', monthNumber: 1),
    MonthModel(monthName: 'February', monthNumber: 2),
    MonthModel(monthName: 'March', monthNumber: 3),
    MonthModel(monthName: 'April', monthNumber: 4),
    MonthModel(monthName: 'May', monthNumber: 5),
    MonthModel(monthName: 'June', monthNumber: 6),
    MonthModel(monthName: 'July', monthNumber: 7),
    MonthModel(monthName: 'August', monthNumber: 8),
    MonthModel(monthName: 'September', monthNumber: 9),
    MonthModel(monthName: 'October', monthNumber: 10),
    MonthModel(monthName: 'November', monthNumber: 11),
    MonthModel(monthName: 'January', monthNumber: 12),
  ];
  DateTime? datePaid;
  MonthModel? rentalMonth;
  double? rentalYear;
  PaymentMethods? paymentMethod;
  final _formKey = GlobalKey<FormState>();
  void _popPage() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    return FormPages(
      pageTitle: 'Add Rental Record',

      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rent for the month of : ',
                style: TextStyle(
                  color: AppColorsConstant.darkBlueColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              //Rental Month
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(label: 'Month', isRequired: true),
                        SizedBox(height: 6),
                        DropdownButtonFormField<MonthModel>(
                          hint: Text(
                            'Select',
                            style: CustomInputDecoration.textInputDecoration()
                                .hintStyle,
                          ),
                          decoration:
                              CustomInputDecoration.textInputDecoration(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: rentalMonths.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.monthName),
                            );
                          }).toList(),

                          onChanged: (value) {
                            setState(() {
                              rentalMonth = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return ' Select an option';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(label: 'Year', isRequired: true),
                        SizedBox(height: 6),
                        FormFieldWidget(
                          controller: yearController,
                          hintText: 'Enter year',
                          needsValidation: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),
              Text(
                'Rent/ Month : Ksh : ${widget.unit.rentPerMonth}',
                style: TextStyle(
                  color: AppColorsConstant.darkBlueColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              FormLabel(label: 'Amount paid', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                needsValidation: true,
                hintText: 'Enter Amount ',
                prefix: Text(
                  'Ksh ',
                  style: CustomTextStyles.cardDescriptionStyle,
                ),
              ),

              SizedBox(height: 15.0),

              //Date of payment
              FormLabel(label: 'Date of payment', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: paymentDateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.datetime,
                enabled: true,
                showCursor: true,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Select date',
                ),
                onTap: () async {
                  final DateTime? selectedDate = await showDatePicker(
                    initialEntryMode: DatePickerEntryMode.input,
                    currentDate: DateTime(
                      int.parse(yearController.text.trim()),
                      rentalMonth?.monthNumber ?? 1,
                      1,
                    ),
                    context: context,
                    firstDate: DateTime(
                      int.parse(yearController.text.trim()),
                      1,
                      1,
                    ),
                    lastDate: DateTime(
                      int.parse(yearController.text.trim()),
                      12,
                      1,
                    ),
                    initialDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    paymentDateController.text =
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                    setState(() {
                      datePaid = selectedDate;
                    });
                    log(
                      'This is the selected date : ${formatPrettyDate(selectedDate)}',
                    );
                  }
                },

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter payment date';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),
              //Payment method
              FormLabel(label: 'Payment method', isRequired: true),
              SizedBox(height: 6),
              DropdownButtonFormField<PaymentMethods>(
                hint: Text(
                  'Select',
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
                ),
                decoration: CustomInputDecoration.textInputDecoration(),
                autovalidateMode: AutovalidateMode.onUserInteraction,

                items: PaymentMethods.values.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type.label));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return ' Select an option';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              //Submit button
              ColorButtonWidget(
                onPressedCallBack: () async {
                  LazyLoader lazyLoader = LazyLoader(context: context);

                  final db = DbRentalService();
                  if (_formKey.currentState!.validate() &&
                      datePaid != null &&
                      paymentMethod != null &&
                      rentalMonth != null) {
                    lazyLoader.showLoader();
                    //Instance of rent history
                    RentHistory rentHistory = RentHistory(
                      tenantId: widget.tenant.tenantId!,
                      unitId: widget.unit.unitId!,
                      userId: currentUser!.uid,
                      tenantName: widget.tenant.tenantName,
                    );
                    //Instance of rental entry
                    SingleRentEntry rentEntry = SingleRentEntry(
                      paymentDate: datePaid!,
                      amountPayable: widget.unit.rentPerMonth,
                      amountPaid: double.parse(amountController.text.trim()),
                      paymentMethod: paymentMethod!,
                      rentalMonth:
                          '${rentalMonth!.monthName} / ${yearController.text.trim()}',
                      rentEntryId:
                          '${rentalMonth?.monthName} / ${yearController.text.trim()} $datePaid',
                      lastUpdatedDate: DateTime.now(),
                    );

                    //  Read from db to see if a rent history for this tenant already exists
                    final tenantRentHistory = await db.getRentHistory(
                      widget.tenant.tenantId!,
                    );
                    if (tenantRentHistory == null) {
                      log('tenant History does not currently exist');
                      //If this tenant has no history .. add a rental history
                      try {
                        //   //append ...ref
                        final newHistory = await ref
                            .read(
                              rentProvider(widget.tenant.tenantId!).notifier,
                            )
                            .addTenantRentHistory(rentHistory);
                        if (newHistory != null) {
                          // Add tenant entry
                          try {
                            final newestEntry = await ref
                                .read(
                                  rentProvider(
                                    widget.tenant.tenantId!,
                                  ).notifier,
                                )
                                .addRentEntry(rentEntry, newHistory);
                            if (newestEntry != null) {
                              //update financial recprds

                              ref
                                  .read(userInformationProvider.notifier)
                                  .appendFinances(
                                    FinancialRecord(
                                      recordId: rentEntry.rentEntryId,
                                      datePaid: rentEntry.paymentDate,
                                      amountPaid: rentEntry.amountPaid,
                                      recordType: FinancialRecordTypes.rent,
                                      recordNature:
                                          FinancialRecordNature.revenue,
                                      paymentMethod:
                                          rentEntry.paymentMethod.label,
                                      lastUpdatedDate:
                                          rentEntry.lastUpdatedDate ??
                                          DateTime.now(),
                                      paymentBy: {
                                        'personName': widget.tenant.tenantName,
                                      },
                                    ),
                                  );
                              displaySnackBar(
                                context,
                                'Rental record added succesfully',
                                AppColorsConstant.greenColor,
                              );
                            }
                            log('New rental entry added succesfully');
                            displaySnackBar(
                              context,
                              'Rental record added succesfully',
                              AppColorsConstant.greenColor,
                            );
                          } catch (e) {
                            log(
                              'Error adding rent entry for new rent history : $e',
                            );
                          } finally {
                            lazyLoader.hideLoader();
                            _popPage();
                          }
                        }
                      } catch (e) {
                        log('Error adding rent History $e');
                      }
                    } else {
                      //Update existing rental history
                      try {
                        //Add the tenant rent entry
                        //append ...ref
                        final newRentEntry = await ref
                            .read(
                              rentProvider(widget.tenant.tenantId!).notifier,
                            )
                            .addRentEntry(rentEntry, tenantRentHistory);
                        if (newRentEntry != null) {
                          //update financial recprds

                          ref
                              .read(userInformationProvider.notifier)
                              .appendFinances(
                                FinancialRecord(
                                  recordId: rentEntry.rentEntryId,
                                  datePaid: rentEntry.paymentDate,
                                  amountPaid: rentEntry.amountPaid,
                                  recordType: FinancialRecordTypes.rent,
                                  recordNature: FinancialRecordNature.revenue,
                                  paymentMethod: rentEntry.paymentMethod.label,
                                  lastUpdatedDate:
                                      rentEntry.lastUpdatedDate ??
                                      DateTime.now(),
                                  paymentBy: {
                                    'personName': widget.tenant.tenantName,
                                  },
                                ),
                              );
                          displaySnackBar(
                            context,
                            'Rental record added succesfully',
                            AppColorsConstant.greenColor,
                          );
                        }
                      } catch (e) {
                        log(
                          'Error adding rent entry for existing rent history : $e',
                        );
                      } finally {
                        lazyLoader.hideLoader();
                        _popPage();
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Enter required fields ')),
                    );
                  }
                },
                buttonTitle: 'Submit',
                buttonColor: AppColorsConstant.greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
