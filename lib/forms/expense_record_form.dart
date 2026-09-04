import 'package:anyamar/commons/exports.dart';

class ExpenseRecord extends StatelessWidget {
  final FinancialRecord? financialRecord;
  const ExpenseRecord({super.key, this.financialRecord});
  @override
  Widget build(BuildContext context) {
    return DashboardForm(
      form: ExpenseRecordFormForm(financialRecord: financialRecord),
    );
  }
}

class ExpenseRecordFormForm extends ConsumerStatefulWidget {
  final FinancialRecord? financialRecord;

  const ExpenseRecordFormForm({super.key, this.financialRecord});

  @override
  ConsumerState<ExpenseRecordFormForm> createState() =>
      _ExpenseRecordFormFormState();
}

class _ExpenseRecordFormFormState extends ConsumerState<ExpenseRecordFormForm> {
  FinancialRecordTypes? financialRecordType;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController datePaidController = TextEditingController();
  final TextEditingController paymentByController = TextEditingController();
  DateTime? paymentDate;
  final _formKey = GlobalKey<FormState>();
  bool get isUpdateMode => widget.financialRecord != null;
  List<Tenant> myTenants = [];
  List<Property> myProperties = [];
  Property? selectedProperty;
  PaymentMethods? paymentMethod;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final record = widget.financialRecord;
    // ADD MODE
    if (record == null) {
      datePaidController.text = formatStandardDate(DateTime.now());
      return;
    }
    // UPDATE MODE
    amountController.text = record.amountPaid.toString();
    datePaidController.text = formatStandardDate(record.datePaid);
    paymentByController.text = record.paymentBy.personName.toString();
    paymentDate = record.datePaid;
    financialRecordType = record.recordType;
    paymentMethod = record.paymentMethod;
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
        paymentDate = parsedDate;
      });
    } catch (e) {
      log('Could not parse payment date "$value": $e');
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    datePaidController.dispose();
    paymentByController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    myTenants = ref.read(
      userInformationProvider.select((state) => state.tenants),
    );
    myProperties = ref.read(
      userInformationProvider.select((state) => state.properties),
    );
    if (widget.financialRecord?.propertyId != null) {
      myProperties
          .where(
            (property) =>
                property.propertyId == widget.financialRecord?.propertyId,
          )
          .single;
    }

    log('myTenants : ${myTenants.map((e) => e.tenantName)}');

    return FormPages(
      pageTitle: isUpdateMode ? 'Update Expense Record' : 'Add Expense Record',
      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ============================================================
              // FINANCIAL RECORD TYPE
              // ============================================================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(label: 'Financial record type', isRequired: true),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<FinancialRecordTypes>(
                    initialValue: financialRecordType,
                    hint: Text(
                      'Select type',
                      style:
                          CustomInputDecoration.textInputDecoration().hintStyle,
                    ),
                    decoration: CustomInputDecoration.textInputDecoration(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    items: FinancialRecordTypes.values
                        .where(
                          (type) =>
                              type.nature == FinancialRecordNature.expense,
                        )
                        .map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.label),
                          );
                        })
                        .toList(),
                    onChanged: (value) async {
                      setState(() {
                        financialRecordType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Select an option';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  // ========================================================
                  // PROPERTY
                  // ========================================================
                  FormLabel(label: 'Property with the expense'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<Property>(
                    initialValue: selectedProperty,
                    hint: Text(
                      'Select property ',
                      style:
                          CustomInputDecoration.textInputDecoration().hintStyle,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: CustomInputDecoration.textInputDecoration(),
                    items: myProperties.map((property) {
                      return DropdownMenuItem<Property>(
                        value: property,
                        child: Text(property.propertyName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProperty = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a property';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  // ======================================================
                  // EXPENSE RECORDS
                  // ======================================================
                  FormLabel(label: 'Amount Paid in Ksh', isRequired: true),
                  const SizedBox(height: 6),
                  FormFieldWidget(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],

                    hintText: 'Enter Amount',
                    prefixIcon: Text(
                      'Ksh ',
                      style: CustomTextStyles.cardDescriptionStyle,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // ======================================================
                  // DATE OF PAYMENT
                  // ======================================================
                  FormLabel(label: 'Date of payment', isRequired: true),
                  const SizedBox(height: 6),
                  FormFieldWidget(
                    controller: datePaidController,
                    keyboardType: TextInputType.datetime,
                    hintText: 'Enter date (date / month / year)',
                    inputFormatters: [DateInputFormatter()],
                    customValidator: validateDate,
                    onChangedCallBack: (value) {
                      _updateDatePaid(value);
                    },
                  ),

                  const SizedBox(height: 15),
                  // ======================================================
                  // PAYMENT BY
                  // ======================================================
                  FormLabel(label: 'Payment By', isRequired: true),
                  const SizedBox(height: 6),
                  FormFieldWidget(
                    controller: paymentByController,
                    hintText: 'Enter Name',
                  ),
                ],
              ),
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
              // ============================================================
              // SUBMIT
              // ============================================================
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (isUpdateMode) {
                    await updateFinancialRecord(context, currentUser);
                  } else {
                    await createFinancialRecord(context, currentUser);
                  }
                },
                fontSize: 12,
                buttonTitle: isUpdateMode ? 'Update Record' : 'Add Record',
                buttonColor: AppColorsConstant.greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ========================================================================
  // CREATE
  // ========================================================================

  Future<void> createFinancialRecord(
    BuildContext context,
    User? currentUser,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (financialRecordType == null || paymentDate == null) {
      displaySnackBar(
        context,
        'Enter all required fields',
        AppColorsConstant.redColor,
      );

      return;
    }
    if (currentUser == null) {
      displaySnackBar(
        context,
        'No authenticated user found',
        AppColorsConstant.redColor,
      );
      return;
    }
    final amount = double.tryParse(amountController.text.trim());
    if (amount == null) {
      displaySnackBar(
        context,
        'Enter a valid amount',
        AppColorsConstant.redColor,
      );

      return;
    }
    final lazyLoader = LazyLoader(context: context);
    lazyLoader.showLoader();
    final db = DbFinancesService();
    final financialRecord = FinancialRecord(
      datePaid: paymentDate!,
      amountPaid: amount,
      recordType: financialRecordType!,
      paymentBy: Person(personName: paymentByController.text.trim()),
      lastUpdatedDate: DateTime.now(),
      recordNature: FinancialRecordNature.expense,
      userId: currentUser.uid,
      propertyId: selectedProperty?.propertyId,
      paymentMethod: paymentMethod,
    );
    try {
      final newRecord = await db.addRecord(financialRecord);
      if (newRecord != null) {
        // update Riverpod state.
        ref.read(userInformationProvider.notifier).appendFinances(newRecord);
      }
      if (!mounted) return;
      displaySnackBar(
        context,
        'Record added successfully',
        AppColorsConstant.greenColor,
      );
    } catch (e, stackTrace) {
      log('Error adding financial record: $e', stackTrace: stackTrace);
      if (!mounted) return;
      displaySnackBar(
        context,
        'Error: $e occurred when adding the record',
        AppColorsConstant.redColor,
      );
    } finally {
      if (mounted) {
        lazyLoader.hideLoader();
        Navigator.pop(context);
      }
    }
  }

  // ========================================================================
  // UPDATE
  // ========================================================================
  Future<void> updateFinancialRecord(
    BuildContext context,
    User? currentUser,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (financialRecordType == null || paymentDate == null) {
      displaySnackBar(
        context,
        'Enter all required fields',
        AppColorsConstant.redColor,
      );

      return;
    }

    if (currentUser == null) {
      displaySnackBar(
        context,
        'No authenticated user found',
        AppColorsConstant.redColor,
      );

      return;
    }

    final amount = double.tryParse(amountController.text.trim());

    if (amount == null) {
      displaySnackBar(
        context,
        'Enter a valid amount',
        AppColorsConstant.redColor,
      );

      return;
    }

    final lazyLoader = LazyLoader(context: context);

    lazyLoader.showLoader();

    final db = DbFinancesService();

    final updatedFinancialRecord = widget.financialRecord!.copyWith(
      datePaid: paymentDate!,
      amountPaid: amount,
      recordType: financialRecordType!,
      paymentBy: Person(personName: paymentByController.text.trim()),
      recordNature: FinancialRecordNature.expense,
      lastUpdatedDate: DateTime.now(),
      userId: currentUser.uid,
      propertyId: selectedProperty?.propertyId,
      paymentMethod: paymentMethod,
    );

    try {
      final updatedRecord = await db.updateRecord(updatedFinancialRecord);
      ref.read(userInformationProvider.notifier).updateFinance(updatedRecord);
      if (!mounted) return;
      displaySnackBar(
        context,
        'Record updated successfully',
        AppColorsConstant.greenColor,
      );
    } catch (e, stackTrace) {
      log('Error updating financial record: $e', stackTrace: stackTrace);

      if (!mounted) return;

      displaySnackBar(
        context,
        'Error: $e occurred when updating the record',
        AppColorsConstant.redColor,
      );
    } finally {
      if (mounted) {
        lazyLoader.hideLoader();
        Navigator.pop(context);
      }
    }
  }
}
