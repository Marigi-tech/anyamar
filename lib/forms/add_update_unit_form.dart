import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/enums/currencies.dart';
import 'package:anyamar/data/models/enums/payment_frequency.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_card_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_item_widget.dart';

class AddOrUpdateUnitForm extends ConsumerStatefulWidget {
  final Unit? unit;
  final Property? currentProperty;
  final bool? isFromTenantPage;
  final bool? isInUnitPage;
  const AddOrUpdateUnitForm({
    super.key,
    this.unit,
    this.currentProperty,
    this.isFromTenantPage,
    this.isInUnitPage,
  });

  @override
  ConsumerState<AddOrUpdateUnitForm> createState() =>
      _AddOrUpdateUnitFormState();
}

class _AddOrUpdateUnitFormState extends ConsumerState<AddOrUpdateUnitForm> {
  // ============================================================
  // CONTROLLERS
  // ============================================================
  final TextEditingController unitNameController = TextEditingController();
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController rentDepositController = TextEditingController();
  final TextEditingController rentCurrencyController = TextEditingController();
  // ============================================================
  // FORM STATE
  // ============================================================
  Property? selectedProperty;
  final List<UnitUtility> unitUtilities = [];
  final _formKey = GlobalKey<FormState>();
  bool get isUpdateMode => widget.unit != null;
  UnitType? selectedUnitType;
  PaymentFrequency? selectedPaymentFrequency;
  String freqShortHand = '';
  Currencies? currency;
  String? selectedCurrency;
  // ============================================================
  // INIT
  // ============================================================
  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final unit = widget.unit;
    // ADD MODE
    if (unit == null) {
      selectedProperty = widget.currentProperty;
      currency = Currencies.ksh;
      selectedCurrency = currency?.label;
      selectedPaymentFrequency = PaymentFrequency.monthly;
      freqShortHand = selectedPaymentFrequency?.label ?? 'month';

      return;
    }
    // ==========================================================
    // UPDATE MODE
    // ==========================================================
    unitNameController.text = unit.unitName;
    propertyNameController.text = unit.propertyName;
    rentController.text = formatMoney(unit.rentPerMonth).toString();
    rentDepositController.text = formatMoney(
      unit.unitRent?.rentDeposit ?? 0.0,
    ).toString();
    floorController.text = unit.numberFloors?.toString() ?? '';
    selectedUnitType = unit.unitType;
    selectedCurrency = unit.unitRent?.rentCurrency;
    currency = getCurrencyFromString(selectedCurrency);
    // selectedPaymentFrequency = unit.unitRent?.paymentFrequency;

    // freqShortHand = getFreqFromPaymentFrequency(selectedPaymentFrequency);
    freqShortHand = unit.unitRent?.paymentFrequency ?? '';
    selectedPaymentFrequency = getFrequencyFromFreq(freqShortHand);
    rentCurrencyController.text = unit.unitRent?.rentCurrency ?? 'Ksh';

    // Existing utilities
    unitUtilities.addAll(unit.unitRent?.utilities ?? []);
  }
  
  // ============================================================
  // RESET
  // ============================================================

  void _resetForm() {
    // Reset all form fields
    _formKey.currentState?.reset();

    // Clear controllers
    unitNameController.clear();
    rentController.clear();
    rentDepositController.clear();
    floorController.clear();
    rentCurrencyController.clear();
    propertyNameController.clear();

    // Reset selected values
    setState(() {
      selectedProperty = null;
      selectedUnitType = null;
      selectedCurrency = null;
      selectedPaymentFrequency = null;
      currency = null;
      // Reset utilities if you have a selected utilities list
      unitUtilities.clear();
    });
  }
  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    unitNameController.dispose();
    propertyNameController.dispose();
    floorController.dispose();
    rentController.dispose();
    rentDepositController.dispose();
    rentCurrencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;

    final List<Property> myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    log('selectedCurrency : $selectedCurrency');
    // ==========================================================
    // FIND PROPERTY IN UPDATE MODE
    // ==========================================================

    if (selectedProperty == null && widget.unit != null) {
      final matchingProperties = myProperties.where(
        (property) => property.propertyId == widget.unit!.propertyId,
      );

      if (matchingProperties.isNotEmpty) {
        selectedProperty = matchingProperties.first;
      }
    }

    // ==========================================================
    // NO PROPERTIES
    // ==========================================================

    if (myProperties.isEmpty) {
      return InfoUnavailableLottie(
        text:
            'There are no properties at the moment, add a property to the system for better management',
        ctaButtonWidget: CardButtonWidget(
          buttonTitle: 'Click here to add a property',
          onPressedCallBack: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddProperty(isFromUnitPage: true),
            ),
          ),
        ),
      );
    }

    // ==========================================================
    // FORM
    // ==========================================================

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========================================================
              // FORM FIELDS
              // ========================================================
          
              FormCardWidget(
                noOfColumnsPerRow: 3,
                formInputs: [
                  // ==================================================
                  // UNIT NAME
                  // ==================================================
                  FormItemWidget(
                    label: 'Unit name / number',
                    required: true,
                    child: FormFieldWidget(
                      controller: unitNameController,
                      hintText: 'Enter unit name / number',
                    ),
                  ),
                  // ==================================================
                  // UNIT TYPE
                  // ==================================================
                  FormItemWidget(
                    label: 'Unit Type',
                    required: true,
                    child: DropdownButtonFormField<UnitType>(
                      initialValue: selectedUnitType,
                      hint: Text(
                        'Select Type',
                        style: CustomInputDecoration.textInputDecoration()
                            .hintStyle,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomInputDecoration.textInputDecoration(),
                      items: UnitType.values.map((unitType) {
                        return DropdownMenuItem<UnitType>(
                          value: unitType,
                          child: Text(unitType.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedUnitType = value;
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

                  // ==================================================
                  // PROPERTY
                  // ==================================================
                  FormItemWidget(
                    label: 'Property',
                    required: true,
                    child: DropdownButtonFormField<Property>(
                      initialValue: selectedProperty,
                      hint: Text(
                        'Select property',
                        style: CustomInputDecoration.textInputDecoration()
                            .hintStyle,
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
                  ),
                  // ==================================================
                  // FLOOR NUMBER
                  // ==================================================
                  if (selectedProperty != null &&
                      selectedProperty!.propertyFloors != 0)
                    FormItemWidget(
                      label: 'Floor number',
                      required: false,
                      child: FormFieldWidget(
                        controller: floorController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        required: false,
                        hintText: 'Enter Floor number',
                      ),
                    ),
                ],
                formCardTitle: 'Basic information',
              ),
              SizedBox(height: 30),
              FormCardWidget(
                noOfColumnsPerRow: 3,
                formInputs: [
                  // ==================================================
                  // Payment Frequency
                  // ==================================================
                  FormItemWidget(
                    label: 'Payment Frequency',
                    required: true,
                    child: DropdownButtonFormField<PaymentFrequency>(
                      initialValue: selectedPaymentFrequency,
                      hint: Text(
                        'Select ',
                        style: CustomInputDecoration.textInputDecoration()
                            .hintStyle,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomInputDecoration.textInputDecoration(),
                      items: PaymentFrequency.values.map((frequency) {
                        return DropdownMenuItem<PaymentFrequency>(
                          value: frequency,
                          child: Text(frequency.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentFrequency = value;
                          freqShortHand = getFreqFromPaymentFrequency(value);
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
                  // ==================================================
                  // Currency
                  // ==================================================
                  FormItemWidget(
                    label: 'Currency',
                    required: false,
                    child: DropdownButtonFormField<Currencies>(
                      initialValue: currency,
                      hint: Text(
                        'Select ',
                        style: CustomInputDecoration.textInputDecoration()
                            .hintStyle,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: CustomInputDecoration.textInputDecoration(),
                      items: Currencies.values.map((currency) {
                        return DropdownMenuItem<Currencies>(
                          value: currency,
                          child: Text(currency.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          currency = value;
                          selectedCurrency = currency?.label ?? '';
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

                  // ==================================================
                  // RENT DEPOSIT
                  // ==================================================
                  FormItemWidget(
                    label: 'Rent Deposit',
                    required: false,
                    child: FormFieldWidget(
                      controller: rentDepositController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [MoneyInputFormatter()],
                      required: false,
                      isMoneyField: true,
                      moneyCurrency: selectedCurrency,
                      hintText: 'Enter rent deposit',
                    ),
                  ),
                  // ==================================================
                  // RENT
                  // ==================================================
                  FormItemWidget(
                    label: 'Rent / $freqShortHand',
                    required: true,

                    child: FormFieldWidget(
                      controller: rentController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [MoneyInputFormatter()],
                      hintText: 'Enter Rent',
                      isMoneyField: true,
                      moneyCurrency: selectedCurrency,
                    ),
                  ),

                  // ========================================================
                  // Utilities
                  // ========================================================
                  _buildUtilitiesSection(),
                ],
                formCardTitle: 'Rental Information',
                formTitleIcon: Icons.wallet,
              ),

              // ========================================================
              // Utilities
              // ========================================================
              const SizedBox(height: 25),

              //  FormCardWidget(children: [_buildUtilitiesSection()]),
              const SizedBox(height: 10),

              // ========================================================
              // UTILITIES
              // ========================================================
              const SizedBox(height: 30),
              // ========================================================
              // SUBMIT BUTTON
              // ========================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Clear Button
                  if (!isUpdateMode)
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
                    buttonTitle: isUpdateMode ? 'Update Unit' : 'Add Unit',
                    buttonIcon: isUpdateMode
                        ? Icon(CupertinoIcons.pen)
                        : Icon(Icons.add),
                    onButtonPressedCallBack: () async {
                      if (isUpdateMode) {
                        await _updateUnit(context, currentUser);
                      } else {
                        await _addUnit(context, currentUser);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),

          //   ],
          // ),
        ),
      ),
    );
  }

  // ================================================================
  // UTILITIES SECTION
  // ================================================================

  Widget _buildUtilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FormLabel(label: 'Utilities', isRequired: false),
            TextButton.icon(
              onPressed: _showAddUtilityDialog,
              icon: Icon(
                CupertinoIcons.add,
                color: AppColorsConstant.darkBlueColor,
              ),
              label: Text(
                'Add Utility',
                style: CustomTextStyles.cardDescriptionStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        if (unitUtilities.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No utilities added.',
              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),

        if (unitUtilities.isNotEmpty)
          SingleChildScrollView(
            child: Column(
              children: unitUtilities.asMap().entries.map((entry) {
                final index = entry.key;
                final utility = entry.value;
                final PropertyUtility propUtility = PropertyUtility.values
                    .where((label) => label.label == utility.utilityName.label)
                    .single;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: InfoTile(
                    tileIcon: getUtilityIcon(propUtility),
                    fontSize: 12,
                    tileTitle: utility.utilityName.label,
                    tileDescription:
                        '$selectedCurrency ${formatMoney(utility.amountPayable)}',
                    trailingWidget: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$selectedCurrency ${formatMoney(utility.amountPayable)}',
                            style: CustomTextStyles.cardDescriptionStyle,
                          ),
                          SizedBox(width: 2),
                          IconButton(
                            tooltip: 'Remove utility',
                            icon: Icon(
                              CupertinoIcons.trash,
                              color: AppColorsConstant.redColor,
                              size: 21,
                            ),
                            onPressed: () {
                              setState(() {
                                unitUtilities.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  // ================================================================
  // ADD UTILITY DIALOG
  // ================================================================

  Future<void> _showAddUtilityDialog() async {
    PropertyUtility? selectedUtility;
    final TextEditingController amountController = TextEditingController();
    try {
      await showDialog(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: Text(
                  'Add Utility',
                  style: CustomTextStyles.cardDescriptionStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ==================================================
                      // UTILITY
                      // ==================================================
                      DropdownButtonFormField<PropertyUtility>(
                        hint: const Text('Select utility'),
                        decoration: CustomInputDecoration.textInputDecoration(),
                        items: PropertyUtility.values.map((utility) {
                          return DropdownMenuItem<PropertyUtility>(
                            value: utility,

                            child: Text(utility.label),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedUtility = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      // ==================================================
                      // AMOUNT
                      // ==================================================
                      FormFieldWidget(
                        controller: amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [MoneyInputFormatter()],
                        required: true,
                        isMoneyField: true,
                        hintText: 'Amount Payable',
                      ),
                    ],
                  ),
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },

                    child: const Text('Cancel'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // ================================================
                      // VALIDATE UTILITY
                      // ================================================

                      if (selectedUtility == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a utility'),
                          ),
                        );

                        return;
                      }

                      // ================================================
                      // VALIDATE AMOUNT
                      // ================================================

                      final amount = double.tryParse(
                        amountController.text.replaceAll(',', ''),
                      );

                      if (amount == null || amount <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Enter a valid utility amount'),
                          ),
                        );

                        return;
                      }

                      // ================================================
                      // PREVENT DUPLICATES
                      // ================================================

                      final alreadyExists = unitUtilities.any(
                        (utility) => utility.utilityName == selectedUtility,
                      );

                      if (alreadyExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColorsConstant.kRed3,
                            content: Text(
                              '${selectedUtility!.label} has already been added',
                            ),
                          ),
                        );

                        return;
                      }
                      // ================================================
                      // ADD UTILITY
                      // ================================================

                      setState(() {
                        unitUtilities.add(
                          UnitUtility(
                            utilityName: selectedUtility!,
                            amountPayable: amount,
                          ),
                        );
                      });

                      Navigator.pop(dialogContext);
                    },

                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      );
    } finally {
      amountController.dispose();
    }
  }

  // ================================================================
  // ADD UNIT
  // ================================================================

  Future<void> _addUnit(BuildContext context, User? currentUser) async {
    if (!_formKey.currentState!.validate()) {
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

    if (selectedProperty == null) {
      displaySnackBar(
        context,
        'Please select a property',
        AppColorsConstant.redColor,
      );

      return;
    }

    final rent = double.tryParse(rentController.text.replaceAll(',', ''));

    if (rent == null) {
      displaySnackBar(
        context,
        'Enter a valid rent amount',
        AppColorsConstant.redColor,
      );

      return;
    }

    final rentDeposit = rentDepositController.text.trim().isEmpty
        ? null
        : double.tryParse(rentDepositController.text.replaceAll(',', ''));

    if (rentDepositController.text.trim().isNotEmpty && rentDeposit == null) {
      displaySnackBar(
        context,
        'Enter a valid rent deposit',
        AppColorsConstant.redColor,
      );

      return;
    }

    final floor = floorController.text.trim().isEmpty
        ? null
        : int.tryParse(floorController.text.trim());
    final db = DbUnitsService();

    final Unit newUnit = Unit(
      propertyId: selectedProperty!.propertyId!,
      unitType: selectedUnitType!,
      propertyName: selectedProperty!.propertyName,
      unitName: unitNameController.text.trim(),
      rentPerMonth: rent,
      unitRent: Rent(
        rentAmount: rent,
        rentDeposit: rentDeposit,
        rentCurrency: selectedCurrency,
        paymentFrequency: freqShortHand,
        // paymentFrequency: selectedPaymentFrequency,
        utilities: List<UnitUtility>.from(unitUtilities),
      ),
      userId: currentUser.uid,
      numberFloors: floor?.toDouble(),
      floorNumber: floor?.toDouble(),
    );

    final lazyLoader = LazyLoader(context: context);
    lazyLoader.showLoader();
    List<Unit> existingUnits = ref.watch(
      userInformationProvider.select((state) => state.units),
    );
    final recordExists = existingUnits.any(
      (existingUnit) =>
          existingUnit.unitName.trim().toLowerCase() ==
              newUnit.unitName.trim().toLowerCase() &&
          existingUnit.unitType.toString().trim().toLowerCase() ==
              newUnit.unitType.toString().trim().toLowerCase() &&
          existingUnit.propertyId.trim().toLowerCase() ==
              newUnit.propertyId.trim().toLowerCase(),
    );
    if (recordExists) {
      lazyLoader.hideLoader();
      displaySnackBar(
        context,
        'A similar property already exists in the database',
        AppColorsConstant.redColor,
      );
    } else {
      try {
        final addedUnit = await db.addUnit(newUnit);

        ref.read(userInformationProvider.notifier).appendUnit(addedUnit);

        if (!mounted) return;

        displaySnackBar(
          context,
          'Unit added successfully',
          AppColorsConstant.greenColor,
        );
        ref.read(unitPageProvider.notifier).showUnit(addedUnit);

        // Navigator.pop(context);
      } catch (e, stackTrace) {
        log('Error adding unit: $e', stackTrace: stackTrace);

        if (!mounted) return;

        displaySnackBar(context, 'Error: $e', AppColorsConstant.redColor);
      } finally {
        if (mounted) {
          lazyLoader.hideLoader();
        }
      }
    }
  }

  // ================================================================
  // UPDATE UNIT
  // ================================================================

  Future<void> _updateUnit(BuildContext context, User? currentUser) async {
    if (!_formKey.currentState!.validate()) {
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

    if (selectedProperty == null) {
      displaySnackBar(
        context,
        'Please select a property',
        AppColorsConstant.redColor,
      );

      return;
    }

    final rent = double.tryParse(rentController.text.replaceAll(',', ''));

    if (rent == null) {
      displaySnackBar(
        context,
        'Enter a valid rent amount',
        AppColorsConstant.redColor,
      );

      return;
    }

    final rentDeposit = rentDepositController.text.trim().isEmpty
        ? null
        : double.tryParse(rentDepositController.text.replaceAll(',', ''));

    if (rentDepositController.text.trim().isNotEmpty && rentDeposit == null) {
      displaySnackBar(
        context,
        'Enter a valid rent deposit',
        AppColorsConstant.redColor,
      );

      return;
    }

    final floor = floorController.text.trim().isEmpty
        ? null
        : int.tryParse(floorController.text.trim());

    final lazyLoader = LazyLoader(context: context);

    lazyLoader.showLoader();

    try {
      final db = DbUnitsService();

      final Unit updatedUnit = widget.unit!.copyWith(
        propertyId: selectedProperty!.propertyId!,
        propertyName: selectedProperty!.propertyName,
        unitName: unitNameController.text.trim(),
        rentPerMonth: rent,
        numberFloors: floor?.toDouble(),
        floorNumber: floor?.toDouble(),
        userId: currentUser.uid,
        unitRent: Rent(
          rentAmount: rent,
          rentDeposit: rentDeposit,
          rentCurrency: selectedCurrency,
          paymentFrequency: freqShortHand,
          // paymentFrequency: selectedPaymentFrequency,
          utilities: List<UnitUtility>.from(unitUtilities),
        ),
        lastUpdateDate: DateTime.now(),
      );

      final result = await db.updateUnit(updatedUnit);

      ref.read(userInformationProvider.notifier).updateUnit(result);

      if (!mounted) return;

      displaySnackBar(
        context,
        'Unit updated successfully',
        AppColorsConstant.greenColor,
      );
      ref.read(unitPageProvider.notifier).showUnit(result);
      // if (widget.isInUnitPage != true) {
      //   Navigator.pop(context);
      // }
    } catch (e, stackTrace) {
      log('Error updating unit: $e', stackTrace: stackTrace);

      if (!mounted) return;

      displaySnackBar(
        context,
        'Error: $e occurred when updating the unit',
        AppColorsConstant.redColor,
      );
    } finally {
      if (mounted) {
        lazyLoader.hideLoader();
      }
    }
  }
}
