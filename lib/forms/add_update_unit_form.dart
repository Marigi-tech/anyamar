import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/enums/currencies.dart';
import 'package:anyamar/data/models/enums/payment_frequency.dart';

class AddOrUpdateUnitForm extends ConsumerStatefulWidget {
  final Unit? unit;
  final Property? currentProperty;
  final bool? isFromTenantPage;
  final bool? isInUnitPage;
  final String introText;

  const AddOrUpdateUnitForm({
    super.key,
    this.unit,
    this.currentProperty,
    this.isFromTenantPage,
    this.isInUnitPage,
    required this.introText,
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
  // Property? selectedProperty;
  final List<UnitUtility> unitUtilities = [];
  final _formKey = GlobalKey<FormState>();
  bool get isUpdateMode => widget.unit != null;
  UnitType? selectedUnitType;
  PaymentFrequency? selectedPaymentFrequency;
  String freqShortHand = '';
  Currencies? currency;
  String? selectedCurrency;
  String? selectedPropertyId;
  List<Property> myProperties = [];
  Property? selectedProperty;

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
      selectedPropertyId = widget.currentProperty?.propertyId;
      currency = Currencies.ksh;
      selectedCurrency = currency?.label;
      selectedPaymentFrequency = PaymentFrequency.monthly;
      freqShortHand = getFreqFromPaymentFrequency(selectedPaymentFrequency);
      floorController.text = '';

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
    // floorController.text = unit.numberFloors?.toString() ?? '';
    if (unit.floorNumber != null) {
      floorController.text = _convertFloorNumberToString(unit.floorNumber!);
    }

    if (widget.currentProperty != null &&
        widget.currentProperty?.propertyFloors != 0) {
      _generatePropertyFloorNumbers(widget.currentProperty!);
    }
    selectedUnitType = unit.unitType;
    selectedCurrency = unit.unitRent?.rentCurrency;
    selectedPropertyId = unit.propertyId;
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
      selectedPropertyId = null;
      selectedUnitType = null;
      selectedCurrency = null;
      selectedPaymentFrequency = null;
      currency = null;
      // Reset utilities if you have a selected utilities list
      unitUtilities.clear();
    });
  }

  //*Generate list of floor Numbers
  List<String> _generatePropertyFloorNumbers(Property selectedP) {
    return [
      'Ground Floor',
      ...List.generate(
        selectedP.propertyFloors.toInt(),
        (index) => '${index + 1} Floor',
      ),
    ];
  }

  //*Convert a unit's floor number to String
  String _convertFloorNumberToString(double floorNumber) {
    if (floorNumber == 0) {
      return 'Ground Floor';
    }

    return '${floorNumber.toInt()} Floor';
  }

  //* Convert a units floor string to Number
  double? _convertFloorStringToNumber(String floor) {
    if (floor.isEmpty) return null;

    if (floor == 'Ground Floor') return 0;

    final match = RegExp(r'^(\d+) Floor$').firstMatch(floor);

    return match != null ? double.tryParse(match.group(1)!) : null;
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
    final appData = ref.watch(userInformationProvider);
    myProperties = appData.properties;

    //! =====================================
    //! UNIT'S PROPERTY IN UPDATE MODE
    //! ======================================
    if (selectedProperty == null && widget.unit != null) {
      selectedProperty = myProperties
          .where((property) => property.propertyId == widget.unit!.propertyId)
          .single;
    }
    //?=======================================
    //? PROPERTY FLOORS LIST
    //?========================================
    final floorOptions = selectedProperty == null
        ? <String>[]
        : _generatePropertyFloorNumbers(selectedProperty!);

    final selectedFloor = floorOptions.contains(floorController.text)
        ? floorController.text
        : null;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: SingleChildScrollView(
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
                      child: DropdownButtonFormField<String>(
                        key: ValueKey(
                          myProperties
                              .map((property) => property.propertyId)
                              .join('|'),
                        ),

                        // Only supply a value that exists in the dropdown items.
                        initialValue:
                            myProperties.any(
                              (property) =>
                                  property.propertyId == selectedPropertyId,
                            )
                            ? selectedPropertyId
                            : null,

                        hint: Text(
                          'Select property',
                          style: CustomInputDecoration.textInputDecoration()
                              .hintStyle,
                        ),

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: CustomInputDecoration.textInputDecoration(),

                        items: myProperties
                            .where((property) => property.propertyId != null)
                            .map((property) {
                              return DropdownMenuItem<String>(
                                value: property.propertyId!,
                                child: Text(property.propertyName),
                              );
                            })
                            .toList(),

                        onChanged: (value) {
                          setState(() {
                            selectedPropertyId = value;

                            selectedProperty = myProperties.firstWhere(
                              (property) => property.propertyId == value,
                            );

                            // Reset the floor when switching properties.
                            floorController.clear();
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
                    // FormItemWidget(
                    //   label: 'Property',
                    //   required: true,
                    //   child: DropdownButtonFormField<Property>(
                    //     initialValue: selectedProperty,
                    //     hint: Text(
                    //       'Select property',
                    //       style: CustomInputDecoration.textInputDecoration()
                    //           .hintStyle,
                    //     ),
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     decoration: CustomInputDecoration.textInputDecoration(),
                    //     items: myProperties.map((property) {
                    //       return DropdownMenuItem<Property>(
                    //         value: property,
                    //         child: Text(property.propertyName),
                    //       );
                    //     }).toList(),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedProperty = value;
                    //         floorController.clear();
                    //       });
                    //     },
                    //     validator: (value) {
                    //       if (value == null) {
                    //         return 'Please select a property';
                    //       }

                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // ==================================================
                    // FLOOR NUMBER
                    // ==================================================
                    if (selectedProperty != null &&
                        selectedProperty!.propertyFloors != 0)
                      DropdownButtonFormField<String>(
                        key: ValueKey('floor-${selectedProperty?.propertyId}'),
                        initialValue: selectedFloor,
                        hint: const Text('Select Floor number'),
                        decoration: CustomInputDecoration.textInputDecoration(),
                        items: floorOptions.map((floor) {
                          return DropdownMenuItem<String>(
                            value: floor,
                            child: Text(floor),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            floorController.text = value ?? '';
                          });
                        },
                      ),
                    // FormItemWidget(
                    //   label: 'Floor number',
                    //   required: false,
                    //   child: DropdownButtonFormField<String>(
                    //     initialValue: floorController.text,
                    //     hint: Text(
                    //       'Select Floor number',
                    //       style: CustomInputDecoration.textInputDecoration()
                    //           .hintStyle,
                    //     ),
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     decoration:
                    //         CustomInputDecoration.textInputDecoration(),
                    //     items:
                    //         _generatePropertyFloorNumbers(
                    //           selectedProperty!,
                    //         ).map((floor) {
                    //           return DropdownMenuItem<String>(
                    //             value: floor,
                    //             child: Text(floor),
                    //           );
                    //         }).toList(),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         floorController.text = value ?? '';
                    //       });
                    //     },
                    //   ),
                    // ),
                    // FormItemWidget(
                    //   label: 'Floor number',
                    //   required: false,
                    //   child: FormFieldWidget(
                    //     controller: floorController,
                    //     keyboardType: TextInputType.number,
                    //     inputFormatters: [
                    //       FilteringTextInputFormatter.digitsOnly,
                    //     ],
                    //     required: false,
                    //     hintText: 'Enter Floor number',
                    //   ),
                    // ),
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
                        keyboardType: TextInputType.number,
                        // keyboardType: const TextInputType.numberWithOptions(
                        //   decimal: true,
                        // ),
                        // inputFormatters: [MoneyInputFormatter()],
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
                        // inputFormatters: [MoneyInputFormatter()],
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
            ElevatedButtonWidget(
              buttonTitle: 'Add utility',
              buttonIcon: Icon(Icons.add),
              onButtonPressedCallBack: _showAddUtilityDialog,
            ),
            // TextButton.icon(
            //   onPressed: _showAddUtilityDialog,
            //   icon: Icon(
            //     CupertinoIcons.add,
            //     color: AppColorsConstant.darkBlueColor,
            //   ),
            //   label: Text(
            //     'Add Utility',
            //     style: CustomTextStyles.cardDescriptionStyle.copyWith(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
          ],
        ),

        const SizedBox(height: 8.0),

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
                    fontSize: 18,
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
                              size: 18,
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
    final isDarkMode = ref.watch(themeIsDarkProvider);
    Color dialogColor = isDarkMode
        ? AppColors.darkElevatedCard
        : AppColors.lightCard;
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (currentUser == null) {
      displaySnackBar(
        context,
        'No authenticated user found',
        dialogColor,
        false,
      );

      return;
    }

    if (selectedProperty == null) {
      displaySnackBar(context, 'Please select a property', dialogColor, false);

      return;
    }

    final rent = double.tryParse(rentController.text.replaceAll(',', ''));

    if (rent == null) {
      displaySnackBar(context, 'Enter a valid rent amount', dialogColor, false);

      return;
    }

    final rentDeposit = rentDepositController.text.trim().isEmpty
        ? null
        : double.tryParse(rentDepositController.text.replaceAll(',', ''));

    if (rentDepositController.text.trim().isNotEmpty && rentDeposit == null) {
      displaySnackBar(
        context,
        'Enter a valid rent deposit',
        dialogColor,
        false,
      );

      return;
    }
    final floor = _convertFloorStringToNumber(floorController.text.trim());
    // final floor = floorController.text.trim().isEmpty
    //     ? null
    //     : int.tryParse(floorController.text.trim());
    final db = DbUnitsService();
    //1: create instance of new unit

    final Unit newUnit = Unit(
      propertyId: selectedProperty!.propertyId!,
      unitType: selectedUnitType!,
      propertyName: selectedProperty!.propertyName,
      unitName: capitalizeFirstLetter(unitNameController.text.trim()),
      // unitName: unitNameController.text.trim(),
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
      lastUpdateDate: DateTime.now(),
    );

    final lazyLoader = LazyLoader(context: context);
    lazyLoader.showLoader();

    //2 : confirm no similar unit exist in the database
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
        dialogColor,
        false,
      );
    } else {
      try {
        //3: add the unit to the database
        final addedUnit = await db.addUnit(newUnit);
        //4: update the local state

        ref.read(userInformationProvider.notifier).appendUnit(addedUnit);
        //5: close the workspace
        ref.read(workspaceProvider.notifier).closeWorkspace();
      } catch (e, stackTrace) {
        log('Error adding unit: $e', stackTrace: stackTrace);

        if (!mounted) return;

        displaySnackBar(context, 'Error: $e', dialogColor, false);
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
    final isDarkMode = ref.watch(themeIsDarkProvider);
    Color dialogColor = isDarkMode
        ? AppColors.darkElevatedCard
        : AppColors.lightCard;
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (currentUser == null) {
      displaySnackBar(
        context,
        'No authenticated user found',
        dialogColor,
        false,
      );

      return;
    }

    if (selectedProperty == null) {
      displaySnackBar(context, 'Please select a property', dialogColor, false);

      return;
    }

    final rent = double.tryParse(rentController.text.replaceAll(',', ''));

    if (rent == null) {
      displaySnackBar(context, 'Enter a valid rent amount', dialogColor, false);

      return;
    }

    final rentDeposit = rentDepositController.text.trim().isEmpty
        ? null
        : double.tryParse(rentDepositController.text.replaceAll(',', ''));

    if (rentDepositController.text.trim().isNotEmpty && rentDeposit == null) {
      displaySnackBar(
        context,
        'Enter a valid rent deposit',
        dialogColor,
        false,
      );

      return;
    }

    final floor = _convertFloorStringToNumber(floorController.text.trim());

    final lazyLoader = LazyLoader(context: context);

    lazyLoader.showLoader();

    try {
      final db = DbUnitsService();
      //1: create instance of unit with it's updated values
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
          utilities: List<UnitUtility>.from(unitUtilities),
        ),
        lastUpdateDate: DateTime.now(),
      );
      //2: update the database
      final result = await db.updateUnit(updatedUnit);
      //3: update local state

      ref.read(userInformationProvider.notifier).updateUnit(result);

      //4: close the workspace
      ref.read(workspaceProvider.notifier).closeWorkspace();
    } catch (e, stackTrace) {
      log('Error updating unit: $e', stackTrace: stackTrace);

      if (!mounted) return;

      displaySnackBar(
        context,
        'Error: $e occurred when updating the unit',
        dialogColor,
        false,
      );
    } finally {
      if (mounted) {
        lazyLoader.hideLoader();
      }
    }
  }
}
