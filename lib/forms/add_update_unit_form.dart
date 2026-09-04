import 'package:anyamar/commons/exports.dart';

class UnitForm extends StatefulWidget {
  final Unit? unit;
  final Property? currentProperty;
  final bool? isFromTenantPage;

  const UnitForm({
    super.key,

    this.unit,
    this.currentProperty,
    this.isFromTenantPage,
  });

  @override
  State<UnitForm> createState() => _UnitFormState();
}

class _UnitFormState extends State<UnitForm> {
  bool get isUpdateMode => widget.unit != null;
  @override
  Widget build(BuildContext context) {
    return FormPages(
      pageTitle: isUpdateMode ? 'Update Unit' : 'Add Unit',
      form: AddOrUpdateUnitForm(
        unit: widget.unit,
        currentProperty: widget.currentProperty,
        isFromTenantPage: widget.isFromTenantPage,
      ),
    );
  }
}

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
  // ============================================================
  // FORM STATE
  // ============================================================
  Property? selectedProperty;
  final List<UnitUtility> unitUtilities = [];
  final _formKey = GlobalKey<FormState>();
  bool get isUpdateMode => widget.unit != null;
  UnitType? selectedUnitType;
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

    // Existing utilities
    unitUtilities.addAll(unit.unitRent?.utilities ?? []);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    final List<Property> myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    // ==========================================================
    //
    // In update mode, selectedProperty is the currrent Property
    // ==========================================================

    if (selectedProperty == null && widget.unit != null) {
      final matchingProperties = myProperties.where(
        (property) => property.propertyId == widget.unit!.propertyId,
      );

      if (matchingProperties.isNotEmpty) {
        selectedProperty = matchingProperties.first;
      }
    }

    return myProperties.isEmpty
        ? InfoUnavailableLottie(
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
          )
        : Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ========================================================
                  // UNIT NAME
                  // ========================================================
                  FormLabel(label: 'Unit name / number', isRequired: true),
                  const SizedBox(height: 6),
                  FormFieldWidget(
                    controller: unitNameController,
                    hintText: 'Enter unit name / number',
                  ),

                  const SizedBox(height: 15),
                  // ========================================================
                  // Unit Type
                  // ========================================================
                  FormLabel(label: 'Unit Type', isRequired: true),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<UnitType>(
                    initialValue: selectedUnitType,
                    hint: Text(
                      'Select Type',
                      style:
                          CustomInputDecoration.textInputDecoration().hintStyle,
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
                  const SizedBox(height: 15),
                  // ========================================================
                  // PROPERTY
                  // ========================================================
                  FormLabel(label: 'Property', isRequired: true),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<Property>(
                    initialValue: selectedProperty,
                    hint: Text(
                      'Select property',
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
                  // ========================================================
                  // ADD PROPERTY IF NONE EXIST
                  // ========================================================
                  if (myProperties.isEmpty) ...[
                    const SizedBox(height: 8),

                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AddProperty()),
                        );
                      },
                      icon: Icon(
                        CupertinoIcons.add,
                        color: AppColorsConstant.darkBlueColor,
                      ),
                      label: const Text('Add Property'),
                    ),
                  ],
                  const SizedBox(height: 15),
                  // ========================================================
                  // RENT INFORMATION
                  // ========================================================
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Rent Information',
                      style: TextStyle(
                        color: AppColorsConstant.darkBlueColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==================================================
                        // RENT
                        // ==================================================
                        FormLabel(label: 'Rent / Month', isRequired: true),
                        const SizedBox(height: 6),
                        FormFieldWidget(
                          controller: rentController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MoneyInputFormatter()],
                          hintText: 'Enter Rent ',
                          isMoneyField: true,
                        ),

                        const SizedBox(height: 8),

                        // ==================================================
                        // RENT DEPOSIT
                        // ==================================================
                        FormLabel(label: 'Rent Deposit', isRequired: false),
                        const SizedBox(height: 6),
                        FormFieldWidget(
                          controller: rentDepositController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [MoneyInputFormatter()],
                          required: false,
                          isMoneyField: true,
                          hintText: 'Enter rent deposit',
                        ),
                        const SizedBox(height: 15),
                        // ==================================================
                        // UTILITIES
                        // ==================================================
                        _buildUtilitiesSection(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // ========================================================
                  // FLOOR NUMBER
                  // ========================================================
                  if (selectedProperty != null &&
                      selectedProperty!.propertyFloors != 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(label: 'Floor number', isRequired: false),
                        const SizedBox(height: 6),
                        FormFieldWidget(
                          controller: floorController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          required: false,
                          hintText: 'Enter Floor number',
                        ),
                      ],
                    ),

                  //? ========================================================
                  //? SUBMIT BUTTON
                  //? ========================================================
                  const SizedBox(height: 30),

                  ColorButtonWidget(
                    onPressedCallBack: () async {
                      if (isUpdateMode) {
                        await _updateUnit(context, currentUser);
                      } else {
                        await _addUnit(context, currentUser);
                      }
                    },
                    buttonTitle: isUpdateMode ? 'Update Unit' : 'Add Unit',
                    buttonColor: AppColorsConstant.greenColor,
                  ),
                ],
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
                  color: AppColorsConstant.blue,
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
                    tileTitle: utility.utilityName.label,
                    tileDescription:
                        'Ksh ${formatMoney(utility.amountPayable)}',
                    trailingWidget: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'KSH ${formatMoney(utility.amountPayable)}',
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
        rentCurrency: 'Ksh',
        paymentFrequency: 'Monthly',
        utilities: List<UnitUtility>.from(unitUtilities),
      ),
      userId: currentUser.uid,
      numberFloors: floor?.toDouble(),
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

        Navigator.pop(context);
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
        userId: currentUser.uid,
        unitRent: Rent(
          rentAmount: rent,
          rentDeposit: rentDeposit,
          rentCurrency: 'Ksh',
          paymentFrequency: 'Monthly',
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

      if (widget.isInUnitPage != true) {
        Navigator.pop(context);
      }
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
