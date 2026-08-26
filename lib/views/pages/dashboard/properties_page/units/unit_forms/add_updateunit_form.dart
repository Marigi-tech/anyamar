import 'dart:developer';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/enums/property_utilities_enum.dart';
import 'package:anyamar/data/models/enums/unit_type_enum.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/rent/rent_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/models/units/utilities/unit_utilities.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/data/services/db_units_service.dart';
import 'package:anyamar/utils/loader/lazy_loader_util.dart';
import 'package:anyamar/utils/snackbar/snackbar_util.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/property_forms/add_property.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_field_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:anyamar/views/reusable_widgets/information_badges/information_badge_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitForm extends ConsumerStatefulWidget {
  final Unit? unit;
  final Property? currentProperty;
  const UnitForm({super.key, this.unit, this.currentProperty});

  @override
  ConsumerState<UnitForm> createState() => _UnitFormState();
}

class _UnitFormState extends ConsumerState<UnitForm> {
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
    rentController.text = unit.rentPerMonth.toString();
    rentDepositController.text = unit.unitRent?.rentDeposit?.toString() ?? '';
    floorController.text = unit.numberFloors?.toString() ?? '';
    selectedUnitType = unit.unitType;
    selectedProperty = widget.currentProperty;
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

    return FormPages(
      pageTitle: isUpdateMode ? 'Update Unit' : 'Add Unit',
      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                needsValidation: true,
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
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
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
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
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
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => AddProperty()));
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
              Text(
                'Rent Information',
                style: TextStyle(
                  color: AppColorsConstant.darkBlueColor,
                  fontStyle: FontStyle.italic,
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
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      needsValidation: true,
                      prefix: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        child: Text('Ksh'),
                      ),
                      hintText: 'Rent / Month',
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      needsValidation: false,
                      prefix: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        child: Text('Ksh'),
                      ),
                      hintText: 'Rent Deposit',
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      needsValidation: false,
                      hintText: 'Enter Floor number',
                    ),
                  ],
                ),

              // ========================================================
              // SUBMIT
              // ========================================================
              const SizedBox(height: 35),

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
                style: TextStyle(color: AppColorsConstant.darkBlueColor),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        if (unitUtilities.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('No utilities added.'),
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
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(getUtilityIcon(propUtility)),
                      title: Text(utility.utilityName.label),
                      subtitle: Text(
                        'Ksh ${utility.amountPayable.toStringAsFixed(2)}',
                      ),

                      trailing: IconButton(
                        tooltip: 'Remove utility',

                        icon: Icon(
                          CupertinoIcons.trash,
                          color: AppColorsConstant.redColor,
                        ),

                        onPressed: () {
                          setState(() {
                            unitUtilities.removeAt(index);
                          });
                        },
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
                title: const Text('Add Utility'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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

                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                        prefix: Text('Ksh '),
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
                        amountController.text.trim(),
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

    final rent = double.tryParse(rentController.text.trim());

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
        : double.tryParse(rentDepositController.text.trim());

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

    final rent = double.tryParse(rentController.text.trim());

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
        : double.tryParse(rentDepositController.text.trim());

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

      Navigator.pop(context);
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
