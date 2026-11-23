import 'package:anyamar/commons/exports.dart';

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
    // totalAmountPayable =
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
      // paymentDateController.text = formatStandardDate(DateTime.now());
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
    final notifier = ref.read(userInformationProvider.notifier);
    myUnits = appData.units;
    myTenants = appData.tenants;

    if (selectedTenant != null) {
      // final rentHistoryAsync = ref.watch(
      //   rentProvider(selectedTenant!.tenantId!),
      // );
      tenantRentalMonths = appData.rentalHistories
          .where((history) => history.tenantId == selectedTenant!.tenantId)
          .expand((history) => history.rentalMonths)
          .toList();
      // rentHistoryAsync.value?.rentalMonths ?? [];
      // these should be months where rental payments are not complete
      viableRentalMonths = tenantRentalMonths.where((month) {
        final totalPerMonth = notifier.calculateMonthlyAmountPayable(
          month.unitRent,
        );

        final totalPaid = notifier.calculateMonthlyAmountPaid(month);
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
        child: SingleChildScrollView(
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
                          // inputFormatters: [DateInputFormatter()],
                          // customValidator: validateDate,
                          inputFormatters: [DateInputFormatter()],
                          onPressedCallBack: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              helpText: 'Select date',
                            );

                            if (pickedDate != null) {
                              final formattedDate =
                                  '${pickedDate.day.toString().padLeft(2, '0')}/'
                                  '${pickedDate.month.toString().padLeft(2, '0')}/'
                                  '${pickedDate.year}';

                              paymentDateController.text = formattedDate;
                              _updateDatePaid(formattedDate);
                            }
                          },
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
  //*==========================================
  //*ADD RENT RECORD
  //*==========================================

  Future<void> _addRentalRecordMethod() async {
    final isDarkMode = ref.watch(themeIsDarkProvider);
    Color dialogColor = isDarkMode
        ? AppColors.darkElevatedCard
        : AppColors.lightCard;
    final lazyLoader = LazyLoader(context: context);

    if (_formKey.currentState?.validate() != true ||
        datePaid == null ||
        paymentMethod == null ||
        selectedMonth == null ||
        selectedUnit == null ||
        selectedTenant == null) {
      displaySnackBar(
        context,
        'Please complete all required fields.',
        dialogColor,
        false,
      );
      return;
    }

    final currentUser = ref.read(authServiceProvider).currentUser;

    if (currentUser == null || selectedTenant!.tenantId == null) {
      displaySnackBar(
        context,
        'Unable to identify the current user or tenant.',
        dialogColor,
        false,
      );
      return;
    }

    lazyLoader.showLoader();

    try {
      final notifier = ref.read(userInformationProvider.notifier);
      final db = DbRentalService();

      final tenant = selectedTenant!;
      final unit = selectedUnit!;

      // 1. Synchronize tenant rental history.
      // This also creates the history if it doesn't exist.
      final history = await notifier.synchronizeTenantRentalMonths(tenant);

      if (history == null) {
        displaySnackBar(
          context,
          'Error: Unable to fetch the tenant\'s rent history, check your connection and try again.',
          dialogColor,
          false,
        );
        throw Exception('Error:Unable to synchronize tenant rental history.');
      }

      // 2. Identify the selected rental month.
      final rentalMonthName =
          widget.rentalMonth?.rentalMonth ??
          '${selectedMonth!.monthName}/${yearController.text.trim()}';

      final existingMonth = history.rentalMonths
          .where((month) => month.rentalMonth == rentalMonthName)
          .firstOrNull;

      if (existingMonth == null) {
        displaySnackBar(
          context,
          'Error: The selected rental month does not exist in the tenant history, check your connection and try again.',
          dialogColor,
          false,
        );
        throw Exception(
          'The selected rental month does not exist in the tenant history.',
        );
      }

      // 3. Determine applicable monthly charges.
      final applicableRent = existingMonth.unitRent;

      if (applicableRent == null) {
        throw Exception(
          'No rental charges have been configured for this month.',
        );
      }

      final amountPayable = notifier.calculateMonthlyAmountPayable(
        applicableRent,
      );

      // 4. Generate a unique payment entry ID.
      final rentEntryId = db.generateRentEntryId(
        tenantName: tenant.tenantName,
        rentalMonths: history.rentalMonths,
      );

      // 5. Create the actual payment transaction.
      final rentEntry = SingleRentEntry(
        paymentDate: datePaid!,
        amountPayable: amountPayable,
        amountPaid: double.parse(amountController.text.replaceAll(',', '')),
        unitId: unit.unitId,
        propertyId: tenant.propertyId,
        tenantId: tenant.tenantId,
        tenantName: tenant.tenantName,
        paymentMethod: paymentMethod!,
        rentalMonth: rentalMonthName,
        rentEntryId: rentEntryId,
        lastUpdatedDate: DateTime.now(),
      );

      // 6. Persist payment and obtain the updated history.

      // final updatedHistory = await ref
      //     .read(rentProvider(tenant.tenantId!).notifier)
      //     .addRentEntry(rentEntry, existingMonth, history);

      final updatedHistory = await db.addRentEntry(
        rentEntry,
        existingMonth,
        history,
      );

      if (updatedHistory == null) {
        throw Exception('Failed to save rental payment.');
      }

      // 7. Update global rental history and rental records.
      notifier.updateRentalHistory(updatedHistory);

      // 8. Append financial revenue record.
      await notifier.appendFinances(
        FinancialRecord(
          recordId: rentEntry.rentEntryId,
          datePaid: rentEntry.paymentDate,
          amountPaid: rentEntry.amountPaid,
          recordType: FinancialRecordTypes.rent,
          recordNature: FinancialRecordNature.revenue,
          paymentMethod: rentEntry.paymentMethod,
          lastUpdatedDate: rentEntry.lastUpdatedDate ?? DateTime.now(),
          paymentBy: Person(personName: tenant.tenantName),
        ),
      );

      // 9. Close workspace.
      ref.read(workspaceProvider.notifier).closeWorkspace();

      displaySnackBar(
        context,
        'Rental payment recorded successfully.',
        dialogColor,
        true,
      );
    } catch (e, stackTrace) {
      log('Error adding rental payment: $e', stackTrace: stackTrace);

      displaySnackBar(
        context,
        'Error adding rental payment: $e',
        dialogColor,
        false,
      );
    } finally {
      lazyLoader.hideLoader();
    }
  }
}
