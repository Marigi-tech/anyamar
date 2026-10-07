import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/enums/currencies.dart';
import 'package:anyamar/data/models/enums/payment_frequency.dart';
import 'package:anyamar/data/providers/page_providers/tenant_page/tenant_page_notifier.dart';
import 'package:anyamar/utils/text_input_formatters/id_or_passport_formatter.dart';
import 'package:anyamar/utils/text_input_formatters/phone_number_formatter.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_card_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_item_widget.dart';

class TenantForm extends ConsumerStatefulWidget {
  final Property? currentProperty;
  final Unit? currentUnit;
  final Tenant? currentTenant;
  const TenantForm({
    super.key,
    this.currentProperty,
    this.currentUnit,
    this.currentTenant,
  });

  @override
  ConsumerState<TenantForm> createState() => _TenantFormState();
}

class _TenantFormState extends ConsumerState<TenantForm> {
  TextEditingController tenantNameController = TextEditingController();
  TextEditingController tenantEmailController = TextEditingController();
  TextEditingController tenantPhoneController = TextEditingController();
  TextEditingController tenantUnitController = TextEditingController();
  TextEditingController tenantNationalIdController = TextEditingController();
  TextEditingController leaseStartController = TextEditingController();
  TextEditingController leaseEndController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController emergencyContactNameController =
      TextEditingController();
  TextEditingController emergencyContactPhoneController =
      TextEditingController();
  TextEditingController emergencyContactEmailController =
      TextEditingController();
  TextEditingController emergencyContactRelationShipController =
      TextEditingController();
  TextEditingController rentCurrencyController = TextEditingController();
  TextEditingController rentDepositController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? pickedFile;
  Unit? selectedUnit;
  DateTime? leaseStart;
  DateTime? leaseEnd;
  Person? nextOfKin;
  List<Property> myProperties = [];
  List<Unit> myVacantUnits = [];
  List<Unit> allUnits = [];
  bool get isUpdateMode => widget.currentTenant != null;
  PaymentFrequency? selectedPaymentFrequency;
  String freqShortHand = '';
  Currencies? currency;
  String? selectedCurrency;
  List<UnitUtility> unitUtilities = [];
  Tenant? currentTenant;

  // ============================================================
  // INIT
  // ============================================================
  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final tenant = currentTenant = widget.currentTenant;

    // ADD MODE
    if (tenant == null) {
      currency = Currencies.ksh;
      selectedCurrency = currency?.label;
      selectedPaymentFrequency = PaymentFrequency.monthly;
      freqShortHand = selectedPaymentFrequency?.label ?? 'month';
      return;
    }
    // ==========================================================
    // UPDATE MODE
    // ==========================================================
    tenantNameController.text = tenant.tenantName.toString();
    tenantEmailController.text = tenant.tenantEmail.toString();
    tenantPhoneController.text = tenant.tenantPhoneNumber.toString();
    tenantUnitController.text = tenant.unitId.toString();
    tenantNationalIdController.text = tenant.tenantNationalId.toString();
    leaseStartController.text = formatStandardDate(tenant.startOfLease);
    if (tenant.endOfLease != null) {
      leaseEndController.text = formatStandardDate(tenant.endOfLease!);
    }
    occupationController.text = tenant.tenantOccupation.toString();
    emergencyContactNameController.text = tenant.nextOfKin?.personName != null
        ? tenant.nextOfKin!.personName.toString()
        : '';
    emergencyContactEmailController.text = tenant.nextOfKin?.personEmail != null
        ? tenant.nextOfKin!.personEmail.toString()
        : '';
    emergencyContactPhoneController.text = tenant.nextOfKin?.personPhone != null
        ? tenant.nextOfKin!.personPhone.toString()
        : '';
    emergencyContactRelationShipController.text =
        tenant.nextOfKin?.relationship != null
        ? tenant.nextOfKin!.personName.toString()
        : '';
    nextOfKin = tenant.nextOfKin;
    leaseStart = tenant.startOfLease;
    leaseEnd = tenant.endOfLease;
    selectedUnit = widget.currentUnit;
    selectedCurrency = tenant.unitRent?.rentCurrency;
    currency = getCurrencyFromString(selectedCurrency);
    rentController.text = tenant.unitRent?.rentAmount.toString() ?? '';
    rentDepositController.text = tenant.unitRent?.rentDeposit.toString() ?? '';
    freqShortHand = tenant.unitRent?.paymentFrequency ?? '';
    selectedPaymentFrequency = getFrequencyFromFreq(freqShortHand);
    rentCurrencyController.text = tenant.unitRent?.rentCurrency ?? 'Ksh';

    // Existing utilities
    unitUtilities.addAll(tenant.unitRent?.utilities ?? []);
  }
  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    tenantNameController.dispose();
    tenantEmailController.dispose();
    tenantPhoneController.dispose();
    tenantUnitController.dispose();
    tenantNationalIdController.dispose();
    leaseStartController.dispose();
    leaseEndController.dispose();
    occupationController.dispose();
    emergencyContactNameController.dispose();
    emergencyContactPhoneController.dispose();
    emergencyContactEmailController.dispose();
    emergencyContactRelationShipController.dispose();
    rentDepositController.dispose();
    rentController.dispose();
    super.dispose();
  }

  void _resetForm() {
    // Reset all form fields
    _formKey.currentState?.reset();

    // Clear controllers
    tenantNameController.clear();
    tenantEmailController.clear();
    tenantPhoneController.clear();
    tenantUnitController.clear();
    tenantNationalIdController.clear();
    leaseStartController.clear();
    leaseEndController.clear();
    occupationController.clear();
    emergencyContactNameController.clear();
    emergencyContactPhoneController.clear();
    emergencyContactEmailController.clear();
    emergencyContactRelationShipController.clear();
    rentDepositController.clear();
    rentController.clear();

    // Reset selected values
    setState(() {
      selectedUnit = null;
      selectedCurrency = null;
      selectedPaymentFrequency = null;
      currency = null;
      // Reset utilities if you have a selected utilities list
      unitUtilities.clear();
    });
  }

  void _updateDatePaid(String value, bool isEnd) {
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
        if (isEnd) {
          leaseEnd = parsedDate;
        } else {
          leaseStart = parsedDate;
        }
      });

      log('datePaid UPDATED: ${isEnd ? leaseEnd : leaseStart} ');
    } catch (e) {
      log('Could not parse payment date "$value": $e');
    }
  }

  popPage() {
    if (currentTenant != null) {
      ref
          .read(tenantPageProvider.notifier)
          .viewTenantInformation(currentTenant!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    final appData = ref.watch(appDataProvider);
    myProperties = appData.properties;
    allUnits = appData.units;
    myVacantUnits = allUnits.where((unit) => unit.isOccupied != true).toList();

    // ==========================================================
    // In update mode, selected Unit
    // ==========================================================
    if (widget.currentUnit != null) {
      selectedUnit = widget.currentUnit;
    }
    if (widget.currentTenant != null) {
      selectedUnit = allUnits
          .where((unit) => unit.unitId == widget.currentTenant?.unitId)
          .single;
    }
    log('selectedUnit: $selectedUnit');
    return allUnits.isEmpty
        ? InfoUnavailableLottie(
            text:
                'There are no units at the moment, add a unit to the system for better management',
            ctaButtonWidget: CardButtonWidget(
              buttonTitle: 'Click here to add a unit',
              // onPressedCallBack: () => Navigator.of(context).push(
              //   // MaterialPageRoute(
              //   //   builder: (_) => AddUnit(
              //   //     currentProperty: widget.currentProperty,
              //   //     isFromTenantPage: true,
              //   //   ),
              //   // ),
              // ),
            ),
          )
        : myVacantUnits.isEmpty
        ? InfoUnavailableLottie(
            text: 'There are currently no vacant units',
            ctaButtonWidget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardButtonWidget(
                  buttonTitle: 'Click here to add a unit',
                  backgroundColor: AppColorsConstant.lightGreenColor,
                  // onPressedCallBack: () => Navigator.of(context).push(
                  //   // MaterialPageRoute(
                  //   //   builder: (_) =>
                  //   //       AddUnit(currentProperty: widget.currentProperty),
                  //   // ),
                ),
                // ),
                SizedBox(height: 06),
                CardButtonWidget(
                  buttonTitle: 'Go back',
                  onPressedCallBack: () => Navigator.pop(context),
                ),
              ],
            ),
          )
        : Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ========================================================
                    // FORM FIELDS
                    // ========================================================
                    //Tenant Information
                    FormCardWidget(
                      noOfColumnsPerRow: 3,
                      formCardTitle: 'Basic tenant information',
                      formTitleIcon: Icons.person,
                      formInputs: [
                        // ==================================================
                        // TENANT NAME
                        // ==================================================
                        FormItemWidget(
                          label: 'Tenant Name',
                          required: true,
                          child: FormFieldWidget(
                            controller: tenantNameController,
                            keyboardType: TextInputType.name,
                            hintText: 'Enter full name',
                          ),
                        ),
                        // ==========================================================
                        // PHONE NUMBER
                        // ==========================================================
                        FormItemWidget(
                          label: 'Phone number',
                          required: true,
                          child: FormFieldWidget(
                            controller: tenantPhoneController,
                            keyboardType: TextInputType.phone,
                            customValidator: validatePhoneNumber,
                            hintText: 'Enter Phone number (07...)',
                          ),
                        ),
                        // ==================================================
                        // EMAIL ADDRESS
                        // ==================================================
                        FormItemWidget(
                          label: 'Email address',
                          required: false,
                          child: FormFieldWidget(
                            controller: tenantEmailController,
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            hintText: 'Enter email address',
                            customValidator: validateEmail,
                          ),
                        ),
                        // ==================================================
                        // NATIONAL ID / PASSPORT NUMBER
                        // ==================================================
                        FormItemWidget(
                          label: 'National ID / Passport Number',
                          required: false,

                          child: FormFieldWidget(
                            controller: tenantNationalIdController,
                            keyboardType: TextInputType.text,
                            inputFormatters: [IdentityDocumentInputFormatter()],
                            hintText: 'Enter National ID or passport number',
                            customValidator: validateIdentityDocument,
                          ),
                        ),
                        // ==================================================
                        // OCCUPATION
                        // ==================================================
                        FormItemWidget(
                          label: 'Occupation / Job',
                          required: false,
                          child: FormFieldWidget(
                            controller: occupationController,
                            keyboardType: TextInputType.text,
                            hintText: 'Enter Occupation',
                            required: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //Unit Information
                    FormCardWidget(
                      noOfColumnsPerRow: 3,
                      formCardTitle: 'Unit Information',
                      formTitleIcon: Icons.house,
                      formInputs: [
                        // ==================================================
                        // SELECT UNIT
                        // ==================================================
                        FormItemWidget(
                          label: 'Unit',
                          required: true,
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Select Unit'),
                            initialValue: selectedUnit?.unitId,
                            decoration:
                                CustomInputDecoration.textInputDecoration(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            items: isUpdateMode
                                ? allUnits
                                      .where((unit) => unit.unitId != null)
                                      .map((unit) {
                                        final property = myProperties
                                            .firstWhere(
                                              (p) =>
                                                  p.propertyId ==
                                                  unit.propertyId,
                                            );

                                        return DropdownMenuItem<String>(
                                          value: unit.unitId!,
                                          child: Text(
                                            '${unit.unitName}, ${property.propertyName}',
                                          ),
                                        );
                                      })
                                      .toList()
                                : myVacantUnits
                                      .where((unit) => unit.unitId != null)
                                      .map((unit) {
                                        final property = myProperties
                                            .firstWhere(
                                              (p) =>
                                                  p.propertyId ==
                                                  unit.propertyId,
                                            );

                                        return DropdownMenuItem<String>(
                                          value: unit.unitId!,
                                          child: Text(
                                            '${unit.unitName}, ${property.propertyName}',
                                          ),
                                        );
                                      })
                                      .toList(),

                            validator: (value) {
                              if (value == null) {
                                return 'Select the unit where the tenant resides';
                              }
                              return null;
                            },

                            onChanged: (unitId) {
                              final unit = myVacantUnits.firstWhere(
                                (unit) => unit.unitId == unitId,
                              );

                              log(
                                'This is the selected Unit: ${unit.unitName}',
                              );

                              setState(() {
                                selectedUnit = unit;
                                if (isUpdateMode != true) {
                                  rentController.text =
                                      selectedUnit?.unitRent?.rentAmount
                                          .toString() ??
                                      '';
                                  rentDepositController.text =
                                      selectedUnit?.unitRent?.rentDeposit
                                          .toString() ??
                                      '';
                                  freqShortHand =
                                      selectedUnit
                                          ?.unitRent
                                          ?.paymentFrequency ??
                                      '';
                                  selectedPaymentFrequency =
                                      getFrequencyFromFreq(freqShortHand);
                                  rentCurrencyController.text =
                                      selectedUnit?.unitRent?.rentCurrency ??
                                      'Ksh';

                                  // Existing utilities
                                  unitUtilities.addAll(
                                    selectedUnit?.unitRent?.utilities ?? [],
                                  );
                                }
                              });
                            },
                          ),
                        ),
                        // ==========================================================
                        // START OF LEASE
                        // ==========================================================
                        FormItemWidget(
                          label: 'Start of lease',
                          required: true,
                          child: FormFieldWidget(
                            controller: leaseStartController,
                            keyboardType: TextInputType.datetime,
                            hintText: 'Enter date (date / month / year)',
                            inputFormatters: [DateInputFormatter()],
                            customValidator: validateDate,
                            onChangedCallBack: (value) {
                              _updateDatePaid(value, false);
                            },
                          ),
                        ),
                        // ==================================================
                        // END OF LEASE
                        // ==================================================
                        if (isUpdateMode)
                          FormItemWidget(
                            label: 'End of lease',
                            required: false,
                            child: FormFieldWidget(
                              controller: leaseEndController,
                              keyboardType: TextInputType.datetime,
                              hintText: 'Enter date (date / month / year)',
                              inputFormatters: [DateInputFormatter()],
                              customValidator: validateDate,
                              required: false,
                              onChangedCallBack: (value) {
                                _updateDatePaid(value, true);
                              },
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 20), // Next of Kin Information
                    FormCardWidget(
                      noOfColumnsPerRow: 3,
                      formCardTitle: 'Next of kin Information',
                      formInputs: [
                        // ==================================================
                        // Name
                        // ==================================================
                        FormItemWidget(
                          label: 'Name',
                          required: true,
                          child: FormFieldWidget(
                            controller: emergencyContactNameController,
                            keyboardType: TextInputType.text,
                            required: true,
                            hintText: 'Enter Name',
                            customValidator: validateUserName,
                          ),
                        ),
                        // ==================================================
                        // Phone number
                        // ==================================================
                        FormItemWidget(
                          label: 'Phone Number',
                          required: true,
                          child: FormFieldWidget(
                            controller: emergencyContactPhoneController,
                            keyboardType: TextInputType.text,
                            required: false,
                            hintText: 'Phone Number',
                            customValidator: validatePhoneNumber,
                          ),
                        ),
                        // ==================================================
                        // Email
                        // ==================================================
                        FormItemWidget(
                          label: 'Email',
                          required: false,
                          child: FormFieldWidget(
                            controller: emergencyContactEmailController,
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            hintText: 'Email',
                            required: false,
                          ),
                        ),
                        // ==================================================
                        // Relationship
                        // ==================================================
                        FormItemWidget(
                          label: 'Relationship with tenant',
                          required: false,
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Select'),
                            decoration:
                                CustomInputDecoration.textInputDecoration(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            items: familyRelations.map((relationship) {
                              return DropdownMenuItem(
                                value: relationship,
                                child: Text(relationship),
                              );
                            }).toList(),
                            onChanged: ((value) {
                              if (value != null) {
                                emergencyContactRelationShipController.text =
                                    value;
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //Rent Information
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration:
                                CustomInputDecoration.textInputDecoration(),
                            items: PaymentFrequency.values.map((frequency) {
                              return DropdownMenuItem<PaymentFrequency>(
                                value: frequency,
                                child: Text(frequency.label),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentFrequency = value;
                                freqShortHand = getFreqFromPaymentFrequency(
                                  value,
                                );
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration:
                                CustomInputDecoration.textInputDecoration(),
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

                    SizedBox(height: 25.0),
                    // ==========================================================
                    // SUBMIT BUTTON
                    // ==========================================================
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
                          buttonTitle: isUpdateMode
                              ? 'Update Tenant'
                              : 'Add Tenant',
                          buttonIcon: isUpdateMode
                              ? Icon(CupertinoIcons.pen)
                              : Icon(Icons.add),
                          onButtonPressedCallBack: () async {
                            if (isUpdateMode) {
                              await updateTenantMethod(context, currentUser);
                            } else {
                              await addTenantMethod(context, currentUser);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  // ==========================================================
  // Add Tenant
  // ==========================================================
  Future<void> addTenantMethod(BuildContext context, User? currentUser) async {
    if (_formKey.currentState!.validate()) {
      if (selectedUnit != null && leaseStart != null) {
        final LazyLoader lazyLoader = LazyLoader(context: context);
        lazyLoader.showLoader();
        final db = DbTenantService();
        final unitDB = DbUnitsService();
        Tenant newTenant = Tenant(
          userId: currentUser!.uid,
          nationalId: tenantNationalIdController.text.trim(),
          unitId: selectedUnit!.unitId!,
          propertyId: selectedUnit!.propertyId,
          tenantName: tenantNameController.text.trim(),
          tenantNationalId: tenantNationalIdController.text.trim(),
          tenantEmail: tenantEmailController.text.trim(),
          tenantOccupation: occupationController.text.trim(),
          tenantPhoneNumber: tenantPhoneController.text.trim(),
          unitName: selectedUnit!.unitName,
          unitRent: selectedUnit!.unitRent,
          startOfLease: leaseStart!,
          lastUpdateDate: DateTime.now(),
          nextOfKin: Person(
            personName: emergencyContactNameController.text.trim(),
            personEmail: emergencyContactEmailController.text.trim(),
            personPhone: emergencyContactPhoneController.text.trim(),
            relationship: emergencyContactRelationShipController.text.trim(),
          ),
        );
        setState(() {
          currentTenant = newTenant;
        });
        List<Tenant> existingTenants = ref.watch(
          userInformationProvider.select((state) => state.tenants),
        );
        final recordExists = existingTenants.any(
          (existingTenants) =>
              existingTenants.tenantName.trim().toLowerCase() ==
                  newTenant.tenantName.trim().toLowerCase() &&
              existingTenants.tenantPhoneNumber.toString().trim() ==
                  newTenant.tenantPhoneNumber.toString().trim(),
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
            Tenant newT = await db.addTenant(newTenant);
            //Update unit status to occupied
            final updatedUnit = selectedUnit!.copyWith(
              isOccupied: true,
              tenantId: newT.tenantId,
              lastUpdateDate: DateTime.now(),
            );
            final savedUnit = await unitDB.updateUnit(updatedUnit);
            ref.read(userInformationProvider.notifier).appendTenant(newT);
            ref.read(userInformationProvider.notifier).updateUnit(savedUnit);

            displaySnackBar(
              context,
              'Tenant added succesfully',
              AppColorsConstant.greenColor,
            );
          } catch (e, stackTrace) {
            log('Error adding tenant: $e', stackTrace: stackTrace);

            displaySnackBar(context, 'Error: $e', AppColorsConstant.redColor);
          } finally {
            lazyLoader.hideLoader();
            popPage();
          }
        }
        log('Select a unit , or start date');
      }
    }
  }

  // ==========================================================
  // Update
  // ==========================================================
  Future<void> updateTenantMethod(
    BuildContext context,
    User? currentUser,
  ) async {
    if (_formKey.currentState!.validate()) {
      log('getting here');
      if (selectedUnit != null && leaseStart != null) {
        final LazyLoader lazyLoader = LazyLoader(context: context);
        lazyLoader.showLoader();
        final db = DbTenantService();
        final unitDB = DbUnitsService();
        Tenant currentTenant = widget.currentTenant!.copyWith(
          userId: currentUser!.uid,
          nationalId: tenantNationalIdController.text.trim(),
          unitId: selectedUnit!.unitId!,
          propertyId: selectedUnit!.propertyId,
          tenantName: tenantNameController.text.trim(),
          tenantNationalId: tenantNationalIdController.text.trim(),
          tenantEmail: tenantEmailController.text.trim(),
          tenantOccupation: occupationController.text.trim(),
          tenantPhoneNumber: tenantPhoneController.text.trim(),
          unitName: selectedUnit!.unitName,
          unitRent: selectedUnit!.unitRent,
          startOfLease: leaseStart!,
          endOfLease: leaseEnd,
          lastUpdateDate: DateTime.now(),
          nextOfKin: Person(
            personName: emergencyContactNameController.text.trim(),
            personEmail: emergencyContactEmailController.text.trim(),
            personPhone: emergencyContactPhoneController.text.trim(),
            relationship: emergencyContactRelationShipController.text.trim(),
          ),
        );
        try {
          Tenant? updatedTenant = await db.updateTenant(currentTenant);
          if (updatedTenant != null) {
            //Update unit status to vacant if the  tenant's lease has ended
            Unit? updatedUnit;
            if (leaseEnd != null &&
                (leaseEnd!.isBefore(DateTime.now()) ||
                    leaseEnd!.isAtSameMomentAs(DateTime.now()))) {
              List<String> previousTenants = [
                ...selectedUnit!.previousTenantsLog,
                widget.currentTenant!.tenantId!,
              ];
              updatedUnit = selectedUnit!.copyWith(
                currentTenant: null,
                isOccupied: false,
                lastUpdateDate: DateTime.now(),
                previousTenantsLog: previousTenants,
              );
            } else {
              updatedUnit = selectedUnit!.copyWith(
                lastUpdateDate: DateTime.now(),
              );
            }
            final savedUnit = await unitDB.updateUnit(updatedUnit);
            ref.read(userInformationProvider.notifier).updateUnit(savedUnit);
            ref
                .read(userInformationProvider.notifier)
                .updateTenant(updatedTenant);

            displaySnackBar(
              context,
              'Tenant added succesfully',
              AppColorsConstant.greenColor,
            );
          }
        } catch (e, stackTrace) {
          log('Error adding tenant: $e', stackTrace: stackTrace);

          displaySnackBar(context, 'Error: $e', AppColorsConstant.redColor);
        } finally {
          lazyLoader.hideLoader();
          popPage();
        }
      }
      log('Select a unit , or start date');
    }
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
      amountController.clear();
    }
  }
}

class AddTenant extends StatelessWidget {
  final Property? currentProperty;
  final Unit? currentUnit;
  final Tenant? currentTenant;
  const AddTenant({
    super.key,
    this.currentProperty,
    this.currentUnit,
    this.currentTenant,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardForm(
      form: TenantForm(
        currentProperty: currentProperty,
        currentUnit: currentUnit,
        currentTenant: currentTenant,
      ),
    );
  }
}
