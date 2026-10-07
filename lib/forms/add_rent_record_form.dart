import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/responsive_form_widget.dart';

class AddRentalRecord extends StatelessWidget {
  final Unit? unit;
  final Tenant? tenant;
  final RentalMonth? rentalMonth;
  const AddRentalRecord({super.key, this.unit, this.tenant, this.rentalMonth});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(
      form: RentalRecordForm(
        tenant: tenant,
        unit: unit,
        rentalMonth: rentalMonth,
      ),
    );
  }
}

class RentalRecordForm extends ConsumerStatefulWidget {
  final Unit? unit;
  final Tenant? tenant;
  final RentalMonth? rentalMonth;
  final VoidCallback? onButtonPressedCallBack;
  const RentalRecordForm({
    super.key,
    this.unit,
    this.tenant,
    this.rentalMonth,
    this.onButtonPressedCallBack,
  });

  @override
  ConsumerState<RentalRecordForm> createState() => _RentalRecordFormState();
}

class _RentalRecordFormState extends ConsumerState<RentalRecordForm> {
  // ============================================================
  // CONTROLLERS
  // ============================================================
  TextEditingController amountController = TextEditingController();
  TextEditingController paymentDateController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  // ============================================================
  // FORM STATE
  // ============================================================
  List<Unit> myUnits = [];
  List<Tenant> myTenants = [];
  Unit? selectedUnit;
  Tenant? selectedTenant;
  DateTime? datePaid;
  RentalMonth? initialMonth;
  MonthModel? selectedMonth;
  String? month;
  String? year;
  double? rentalYear;
  PaymentMethods? paymentMethod;
  double? totalAmountPayable;
  List<RentalMonth> tenantRentalMonths = [];
  List<RentalMonth> viableRentalMonths = [];
  final _formKey = GlobalKey<FormState>();
  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  // ============================================================
  // INITIALIZE FORM METHOD
  // ============================================================
  void _initializeForm() {
    selectedTenant = widget.tenant;
    totalAmountPayable = selectedTenant != null
        ? selectedTenant!.unitRent!.rentAmount +
              (selectedTenant!.unitRent?.utilities ?? []).fold<double>(
                0,
                (sum, utility) => sum + utility.amountPayable,
              )
        : 0.0;
    if (widget.rentalMonth != null) {
      initialMonth = widget.rentalMonth;
      final parts = initialMonth!.rentalMonth.split('/');
      if (parts.length != 2) {
        return;
      }
      month = parts[0].trim();
      year = parts[1].trim();

      selectedMonth = MonthModel(
        monthName: month!,
        monthNumber: getMonthNumber(month!),
      );
      yearController.text = year.toString();
    }
    final initialRecord = widget.rentalMonth;
    // ADD MODE
    if (initialRecord == null) {
      paymentDateController.text = formatStandardDate(DateTime.now());
      datePaid = DateTime.now();

      return;
    } else {
      // UPDATE MODE
      final rentalMonthString = initialRecord.rentalMonth;
      final parts = rentalMonthString.split('/');
      if (parts.length != 2) {
        log('Invalid rental month format: $rentalMonthString');
        return;
      }
      month = parts[0].trim();
      year = parts[1].trim();
      log('Month: $month');
      log('Year: $year');

      selectedMonth = MonthModel(
        monthName: month!,
        monthNumber: getMonthNumber(month!),
      );

      yearController.text = year!;
      // Default payment date for this rental month.
      final initialDate = DateTime(
        int.parse(year!),
        selectedMonth!.monthNumber,
        1,
      );
      datePaid = initialDate;
      paymentDateController.text =
          '${initialDate.day}/${initialDate.month}/${initialDate.year}';

      log('Initial datePaid: $datePaid');

      totalAmountPayable = initialRecord.unitRent != null
          ? initialRecord.unitRent!.rentAmount +
                (widget.rentalMonth!.unitRent?.utilities ?? []).fold<double>(
                  0,
                  (sum, utility) => sum + utility.amountPayable,
                )
          : 0.0;
    }
  }

  void _updateDatePaid(String value) {
    final parts = value.split('/');
    if (parts.length != 3) {
      return;
    }
    try {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final parsedDate = DateTime(year, month, day);

      // Make sure Dart didn't normalize an invalid date.
      if (parsedDate.year != year ||
          parsedDate.month != month ||
          parsedDate.day != day) {
        return;
      }

      setState(() {
        datePaid = parsedDate;
      });

      log('datePaid UPDATED: $datePaid');
    } catch (e) {
      log('Could not parse payment date "$value": $e');
    }
  }

  @override
  void dispose() {
    amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rentalUser = ref.watch(authServiceProvider).currentUser;
    myUnits = ref.watch(userInformationProvider.select((state) => state.units));
    myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );
    if (selectedTenant != null) {
      final rentHistoryAsync = ref.watch(
        rentProvider(selectedTenant!.tenantId!),
      );
      tenantRentalMonths = rentHistoryAsync.value?.rentalMonths ?? [];

      viableRentalMonths = tenantRentalMonths.where((month) {
        final totalPerMonth =
            month.unitRent!.rentAmount +
            (month.unitRent?.utilities ?? []).fold<double>(
              0,
              (sum, utility) => sum + utility.amountPayable,
            );
        final totalPaid = month.rentEntries.fold<double>(
          0.0,
          (sum, entry) => sum + entry.amountPaid,
        );
        return totalPaid < totalPerMonth;
      }).toList();
    }

    selectedUnit =
        widget.unit ??
        myUnits
            .where((unit) => unit.unitId == selectedTenant?.unitId)
            .singleOrNull;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ResponsiveFormWidget(
            children: [
              // ============================================================
              // TENANT
              // ============================================================
              if (widget.tenant == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(label: 'Select Tenant', isRequired: true),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<Tenant>(
                      initialValue: selectedTenant,
                      hint: Text(
                        'Select tenant',
                        style: CustomInputDecoration.textInputDecoration()
                            .hintStyle,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomInputDecoration.textInputDecoration(),
                      items: myTenants.map((tenant) {
                        return DropdownMenuItem<Tenant>(
                          value: tenant,
                          child: Text(tenant.tenantName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedTenant = value;

                            selectedUnit = myUnits
                                .where((unit) => unit.unitId == value.unitId)
                                .single;

                            totalAmountPayable = selectedTenant != null
                                ? selectedTenant!.unitRent!.rentAmount +
                                      (selectedTenant!.unitRent?.utilities ??
                                              [])
                                          .fold<double>(
                                            0,
                                            (sum, utility) =>
                                                sum + utility.amountPayable,
                                          )
                                : 0.0;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a tenant';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              Text(''),

              // ============================================================
              // TOTAL OWED
              // ============================================================
              if (selectedTenant != null)
                Text(
                  'Total Owed / Month : Ksh : '
                  '${formatMoney(totalAmountPayable ?? 0.0)}',
                  style: TextStyle(
                    color: AppColorsConstant.darkBlueColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              Text(''),

              if (selectedTenant != null)
                // ============================================================
                // RENTAL MONTH
                // ============================================================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              FormLabel(
                                label: ' Rent for the month of :',
                                isRequired: true,
                              ),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<RentalMonth>(
                                initialValue: initialMonth,
                                hint: Text(
                                  'Select',
                                  style:
                                      CustomInputDecoration.textInputDecoration()
                                          .hintStyle,
                                ),
                                decoration:
                                    CustomInputDecoration.textInputDecoration(),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                items: viableRentalMonths.map((type) {
                                  return DropdownMenuItem<RentalMonth>(
                                    value: type,
                                    child: Text(type.rentalMonth),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    final parts = value.rentalMonth.split('/');

                                    final monthName = parts[0];

                                    setState(() {
                                      selectedMonth = MonthModel(
                                        monthName: monthName,
                                        monthNumber: getMonthNumber(monthName),
                                      );

                                      yearController.text = parts[1];
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Select an option';
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        // ============================================================
                        // YEAR
                        // ============================================================
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormLabel(label: 'Year', isRequired: true),
                              const SizedBox(height: 6),
                              FormFieldWidget(
                                controller: yearController,
                                hintText: 'Enter year',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              // ============================================================
              // AMOUNT PAID
              // ============================================================
              if (selectedTenant != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(label: 'Amount paid', isRequired: true),
                    const SizedBox(height: 6),
                    FormFieldWidget(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [MoneyInputFormatter()],
                      hintText: 'Enter Amount',
                      prefix: Text(
                        'Ksh ',
                        style: CustomTextStyles.cardDescriptionStyle,
                      ),
                    ),
                  ],
                ),

              // ============================================================
              // PAYMENT DATE
              // ============================================================
              if (selectedTenant != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(label: 'Date of payment', isRequired: true),
                    const SizedBox(height: 6),
                    FormFieldWidget(
                      controller: paymentDateController,
                      keyboardType: TextInputType.datetime,
                      hintText: 'Enter date (date / month / year)',
                      inputFormatters: [DateInputFormatter()],
                      customValidator: validateDate,
                      onChangedCallBack: (value) {
                        _updateDatePaid(value);
                      },
                    ),
                  ],
                ),

              // ============================================================
              // PAYMENT METHOD
              // ============================================================
              if (selectedTenant != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(label: 'Payment method', isRequired: true),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<PaymentMethods>(
                      hint: Text(
                        'Select',
                        style: CustomInputDecoration.textInputDecoration()
                            .hintStyle,
                      ),
                      decoration: CustomInputDecoration.textInputDecoration(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      items: PaymentMethods.values.map((type) {
                        return DropdownMenuItem<PaymentMethods>(
                          value: type,
                          child: Text(type.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Select an option';
                        }

                        return null;
                      },
                    ),
                  ],
                ),

              // ============================================================
              // SUBMIT BUTTON
              // ============================================================
              if (selectedTenant != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ColorButtonWidget(
                      onPressedCallBack: () async {
                        LazyLoader lazyLoader = LazyLoader(context: context);

                        final db = DbRentalService();

                        if (_formKey.currentState!.validate() &&
                            datePaid != null &&
                            paymentMethod != null &&
                            selectedMonth != null &&
                            selectedTenant != null &&
                            selectedUnit != null) {
                          lazyLoader.showLoader();

                          // ========================================================
                          // RENT HISTORY
                          // ========================================================
                          RentHistory newRentHistory = RentHistory(
                            tenantId: selectedTenant?.tenantId ?? '',
                            unitId: selectedUnit?.unitId ?? '',
                            userId: rentalUser!.uid,
                            tenantName: selectedTenant?.tenantName,
                          );

                          // ========================================================
                          // RENT ENTRY
                          // ========================================================
                          //Generate rentalId

                          // ========================================================
                          // CHECK EXISTING RENT HISTORY
                          // ========================================================
                          final tenantRentHistory = await db.getRentHistory(
                            selectedTenant!.tenantId!,
                          );
                          //==========================================================
                          // INSTANCE OF SINGLE ENTRY
                          //==========================================================
                          //? ==============================
                          //? GeneratIng rentEntry Id (YK0001)
                          //?================================

                          final rentEntryId = db.generateRentEntryId(
                            tenantName: selectedTenant!.tenantName,
                            rentalMonths: tenantRentHistory != null
                                ? tenantRentHistory.rentalMonths
                                : newRentHistory.rentalMonths,
                          );
                          SingleRentEntry rentEntry = SingleRentEntry(
                            paymentDate: datePaid!,
                            amountPayable: selectedUnit?.rentPerMonth ?? 0.0,
                            amountPaid: double.parse(
                              amountController.text.replaceAll(',', ''),
                            ),
                            unitId: selectedUnit!.unitId,
                            tenantId: selectedTenant!.tenantId,
                            tenantName: selectedTenant!.tenantName,
                            paymentMethod: paymentMethod!,
                            rentalMonth:
                                widget.rentalMonth?.rentalMonth ??
                                '${selectedMonth?.monthName}/${yearController.text.trim()}',
                            rentEntryId: rentEntryId,
                            lastUpdatedDate: DateTime.now(),
                          );

                          if (tenantRentHistory == null) {
                            log('Tenant history does not currently exist');

                            await rentEntryForNewHistory(
                              newRentHistory,
                              rentEntry,
                              context,
                              lazyLoader,
                            );
                          } else {
                            await rentEntryForExistingHistory(
                              rentEntry,
                              tenantRentHistory,
                              context,
                              lazyLoader,
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Enter required fields\n'
                                'date paid: $datePaid\n'
                                'payment method: $paymentMethod\n'
                                'selected month: '
                                '${selectedMonth?.monthName}\n'
                                'tenant name: '
                                '${selectedTenant?.tenantName}\n'
                                'unit name: '
                                '${selectedUnit?.unitName}',
                              ),
                            ),
                          );
                        }
                      },
                      buttonTitle: 'Submit',
                      buttonColor: AppColorsConstant.greenColor,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> rentEntryForExistingHistory(
    SingleRentEntry rentEntry,
    RentHistory tenantRentHistory,
    BuildContext context,
    LazyLoader lazyLoader,
  ) async {
    // Find the rental month
    final existingMonth = tenantRentHistory.rentalMonths
        .where((month) => month.rentalMonth == rentEntry.rentalMonth)
        .firstOrNull;

    final RentalMonth actualMonth;

    if (existingMonth != null) {
      log('Rental month already exists');
      // Month already exists.
      // The DB method will add the entry to it.
      actualMonth = existingMonth;
    } else {
      log('Rental month does not exsist and new one has been added');
      // Month doesn't exist yet.
      actualMonth = RentalMonth(
        rentalMonth: rentEntry.rentalMonth,
        rentEntries: [],
        unitRent: selectedUnit?.unitRent,
      );
    }
    try {
      final updatedHistory = await ref
          .read(rentProvider(selectedTenant!.tenantId!).notifier)
          .addRentEntry(rentEntry, actualMonth, tenantRentHistory);

      if (updatedHistory != null) {
        ref
            .read(userInformationProvider.notifier)
            .updateTenant(selectedTenant!);
        ref
            .read(userInformationProvider.notifier)
            .appendFinances(
              FinancialRecord(
                recordId: rentEntry.rentEntryId,
                datePaid: rentEntry.paymentDate,
                amountPaid: rentEntry.amountPaid,
                recordType: FinancialRecordTypes.rent,
                recordNature: FinancialRecordNature.revenue,
                paymentMethod: rentEntry.paymentMethod,
                lastUpdatedDate: rentEntry.lastUpdatedDate ?? DateTime.now(),
                paymentBy: Person(personName: selectedTenant!.tenantName),
              ),
            );

        displaySnackBar(
          context,
          'Rental record added successfully',
          AppColorsConstant.greenColor,
        );
        ref.read(financesPageProvider.notifier).viewRentEntryRecord(rentEntry);
      }
    } catch (e) {
      log('Error adding rent entry for existing rent history: $e');

      displaySnackBar(
        context,
        'Error adding rental record: $e',
        AppColorsConstant.redColor,
      );
    } finally {
      lazyLoader.hideLoader();
      if (context.mounted) {}
    }
  }

  Future<void> rentEntryForNewHistory(
    RentHistory rentHistory,
    SingleRentEntry rentEntry,
    BuildContext context,
    LazyLoader lazyLoader,
  ) async {
    try {
      final historyWithMonth = rentHistory.copyWith(
        rentalMonths: [
          RentalMonth(
            rentalMonth: rentEntry.rentalMonth,
            rentEntries: [rentEntry],
          ),
        ],
      );

      final newHistory = await ref
          .read(rentProvider(selectedTenant!.tenantId!).notifier)
          .addTenantRentHistory(historyWithMonth);

      if (newHistory == null) {
        return;
      }

      // Add financial record locally.
      ref
          .read(userInformationProvider.notifier)
          .appendFinances(
            FinancialRecord(
              recordId: rentEntry.rentEntryId,
              datePaid: rentEntry.paymentDate,
              amountPaid: rentEntry.amountPaid,
              recordType: FinancialRecordTypes.rent,
              recordNature: FinancialRecordNature.revenue,
              paymentMethod: rentEntry.paymentMethod,
              lastUpdatedDate: rentEntry.lastUpdatedDate ?? DateTime.now(),
              paymentBy: Person(personName: selectedTenant!.tenantName),
            ),
          );

      displaySnackBar(
        context,
        'Rental record added successfully',
        AppColorsConstant.greenColor,
      );
      ref.read(financesPageProvider.notifier).viewRentEntryRecord(rentEntry);
    } catch (e) {
      log('Error adding rent history: $e');
    } finally {
      lazyLoader.hideLoader();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
