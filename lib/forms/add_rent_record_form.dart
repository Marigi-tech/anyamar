import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_card_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_item_widget.dart';

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
  // ============================================================
  // RESET
  // ============================================================

  void _resetForm() {
    // Reset all form fields
    _formKey.currentState?.reset();

    // Clear controllers
    amountController.clear();
    paymentDateController.clear();
    yearController.clear();

    // Reset selected values
    setState(() {
      paymentMethod = null;
      datePaid = null;
      year = null;
    });
  }

  @override
  void dispose() {
    amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(userInformationProvider);
    myUnits = appData.units;
    myTenants = appData.tenants;

    if (selectedTenant != null) {
      // final rentHistoryAsync = ref.watch(
      //   rentProvider(selectedTenant!.tenantId!),
      // );
      tenantRentalMonths = appData.rentalRecords
          .where((record) => record.tenantId == selectedTenant!.tenantId)
          .map((record) => record.rentalMonth)
          .toList();
      // rentHistoryAsync.value?.rentalMonths ?? [];
      // these should be months where rental payments are not complete
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
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.0),
                FormCardWidget(
                  noOfColumnsPerRow: 3,
                  formCardTitle: 'Rent record Information',
                  supplementaryInfoWidget: selectedTenant != null
                      ? Text(
                          'Total Owed / Month :  '
                          '${formatMoneyWithCurrency(totalAmountPayable ?? 0.0, 'Ksh')}',
                          style: CustomTextStyles.cardDescriptionStyle.copyWith(
                            color: AppColorsConstant.darkBlueColor,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                          ),
                        )
                      : SizedBox.shrink(),

                  formTitleIcon: Icons.apartment,
                  formInputs: [
                    // ========================================================
                    // TENANT
                    // ========================================================
                    FormItemWidget(
                      label: 'Tenant ',
                      required: true,
                      child: DropdownButtonFormField<Tenant>(
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
                    ),

                    //=======================================================================
                    // RENT FOR THE MONTH OF
                    //========================================================================
                    FormItemWidget(
                      label: 'Rent for the month of',
                      required: true,
                      child: DropdownButtonFormField<RentalMonth>(
                        initialValue: initialMonth,
                        hint: Text(
                          'Select',
                          style: CustomInputDecoration.textInputDecoration()
                              .hintStyle,
                        ),
                        decoration: CustomInputDecoration.textInputDecoration(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    ),
                    // ========================================================
                    // YEAR
                    // ========================================================
                    FormItemWidget(
                      label: 'Year',
                      required: true,
                      child: FormFieldWidget(
                        controller: yearController,
                        keyboardType: TextInputType.datetime,
                        hintText: 'Enter date (date / month / year)',
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly,
                        ],

                        // customValidator: validateDate,
                      ),
                    ),

                    // ========================================================
                    // AMOUNT PAID
                    // ========================================================
                    if (selectedTenant != null)
                      FormItemWidget(
                        label: 'Amount paid',
                        required: true,
                        child: FormFieldWidget(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MoneyInputFormatter()],
                          hintText: 'Enter Amount',
                          prefix: Text(
                            'Ksh ',
                            style: CustomTextStyles.cardDescriptionStyle,
                          ),
                        ),
                      ),

                    // ========================================================
                    // DATE PAID
                    // ========================================================
                    if (selectedTenant != null)
                      FormItemWidget(
                        label: 'Date paid',
                        required: true,
                        child: FormFieldWidget(
                          controller: paymentDateController,
                          keyboardType: TextInputType.datetime,
                          hintText: 'Enter date (date / month / year)',
                          inputFormatters: [DateInputFormatter()],
                          customValidator: validateDate,
                          onChangedCallBack: (value) {
                            _updateDatePaid(value);
                          },
                        ),
                      ),

                    // ========================================================
                    // PAYMENT METHOD
                    // ========================================================
                    if (selectedTenant != null)
                      FormItemWidget(
                        label: 'Payment Method',
                        required: true,
                        child: DropdownButtonFormField<PaymentMethods>(
                          hint: Text(
                            'Select',
                            style: CustomInputDecoration.textInputDecoration()
                                .hintStyle,
                          ),
                          decoration:
                              CustomInputDecoration.textInputDecoration(),
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
                      ),
                  ],
                ),
                SizedBox(height: 30.0),

                // ========================================================
                // SUBMIT BUTTON
                // ========================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Clear Button
                    ElevatedButtonWidget(
                      buttonTitle: 'Reset',
                      isClear: true,
                      onButtonPressedCallBack: () async {
                        _resetForm();
                      },
                    ),
                    SizedBox(width: 10),
                    //Submit button
                    ElevatedButtonWidget(
                      buttonTitle: 'Add Record',
                      buttonIcon: Icon(Icons.add),
                      onButtonPressedCallBack: () {
                        _addRentalRecordMethod();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //===================================================================
  // ADD RENTAL RECORD
  //===================================================================
  Future<void> _addRentalRecordMethod() async {
    LazyLoader lazyLoader = LazyLoader(context: context);
    final rentalUser = ref.watch(authServiceProvider).currentUser;

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
        amountPaid: double.parse(amountController.text.replaceAll(',', '')),
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
      ref.read(workspaceProvider.notifier).closeWorkspace();
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
    } catch (e) {
      log('Error adding rent history: $e');
    } finally {
      lazyLoader.hideLoader();
      if (context.mounted) {
        Navigator.of(context).pop();
        ref.read(workspaceProvider.notifier).closeWorkspace();
      }
    }
  }
}
