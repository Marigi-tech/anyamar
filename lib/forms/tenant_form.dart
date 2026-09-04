import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/utils/text_input_formatters/id_or_passport_formatter.dart';
import 'package:anyamar/utils/text_input_formatters/phone_number_formatter.dart';

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

  // ============================================================
  // INIT
  // ============================================================
  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final tenant = widget.currentTenant;

    // ADD MODE
    if (tenant == null) {
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
    super.dispose();
  }

  popPage() {
    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    allUnits = ref.watch(
      userInformationProvider.select((state) => state.units),
    );
    myVacantUnits = ref
        .watch(userInformationProvider.select((state) => state.units))
        .where((unit) => unit.isOccupied != true)
        .toList();

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
              onPressedCallBack: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddUnit(
                    currentProperty: widget.currentProperty,
                    isFromTenantPage: true,
                  ),
                ),
              ),
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
                  onPressedCallBack: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          AddUnit(currentProperty: widget.currentProperty),
                    ),
                  ),
                ),
                SizedBox(height: 06),
                CardButtonWidget(
                  buttonTitle: 'Go back',
                  onPressedCallBack: () => Navigator.pop(context),
                ),
              ],
            ),
          )
        : FormPages(
            pageTitle: isUpdateMode ? 'Update Tenant' : 'Add Tenant',
            form: Form(
              key: _formKey,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ==========================================================
                    // Tenant Name
                    // ==========================================================
                    FormLabel(label: 'Full name', isRequired: true),
                    SizedBox(height: 6),
                    FormFieldWidget(
                      controller: tenantNameController,
                      keyboardType: TextInputType.name,
                      hintText: 'Enter full name',
                    ),
                    SizedBox(height: 15.0),
                    // ==========================================================
                    // Tenant Email
                    // ==========================================================
                    FormLabel(label: 'Email address'),
                    SizedBox(height: 6),
                    FormFieldWidget(
                      controller: tenantEmailController,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      hintText: 'Enter email address',
                      customValidator: validateEmail,
                    ),
                    SizedBox(height: 15.0),
                    // ==========================================================
                    // Tenant Phone
                    // ==========================================================
                    FormLabel(label: 'Phone number', isRequired: true),
                    SizedBox(height: 6),
                    FormFieldWidget(
                      controller: tenantPhoneController,
                      keyboardType: TextInputType.phone,
                      customValidator: validatePhoneNumber,
                      hintText: 'Enter Phone number (07...)',
                    ),
                    SizedBox(height: 15.0),
                    // ==========================================================
                    // National Id / Passport Number
                    // ==========================================================
                    FormLabel(
                      label: 'National ID / Passport number',
                      isRequired: true,
                    ),
                    SizedBox(height: 6),
                    FormFieldWidget(
                      controller: tenantNationalIdController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [IdentityDocumentInputFormatter()],
                      hintText: 'Enter National ID or passport number',
                      customValidator: validateIdentityDocument,
                    ),
                    SizedBox(height: 15.0),
                    // ==========================================================
                    // Select Unit
                    // ==========================================================
                    FormLabel(label: 'Occupied unit', isRequired: true),
                    SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      hint: const Text('Select Unit'),
                      initialValue: selectedUnit?.unitId,
                      decoration: CustomInputDecoration.textInputDecoration(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      items: isUpdateMode
                          ? allUnits.where((unit) => unit.unitId != null).map((
                              unit,
                            ) {
                              final property = myProperties.firstWhere(
                                (p) => p.propertyId == unit.propertyId,
                              );

                              return DropdownMenuItem<String>(
                                value: unit.unitId!,
                                child: Text(
                                  '${unit.unitName}, ${property.propertyName}',
                                ),
                              );
                            }).toList()
                          : myVacantUnits
                                .where((unit) => unit.unitId != null)
                                .map((unit) {
                                  final property = myProperties.firstWhere(
                                    (p) => p.propertyId == unit.propertyId,
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

                        log('This is the selected Unit: ${unit.unitName}');

                        setState(() {
                          selectedUnit = unit;
                        });
                      },
                    ),

                    SizedBox(height: 15.0),
                    // ==========================================================
                    // Start of lease / Date of moving in
                    // ==========================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Start of lease
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormLabel(
                                label: 'Enter start of lease',
                                isRequired: true,
                              ),
                              SizedBox(height: 6),
                              FormFieldWidget(
                                controller: leaseStartController,
                                keyboardType: TextInputType.datetime,
                                hintText: 'Enter date (date / month / year)',
                                inputFormatters: [DateInputFormatter()],
                                customValidator: validateDate,
                                onChangedCallBack: (value) {
                                  _updateDatePaid(value, false);
                                },
                              ),
                            ],
                          ),
                        ),
                        //?End of lease date makes sense only when updating a tenant
                        //?As they may have moved out
                        // ==========================================================
                        // End of lease / Date of moving out
                        // ==========================================================
                        if (isUpdateMode == true) SizedBox(width: 10.0),
                        if (isUpdateMode == true)
                          //End of lease
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FormLabel(
                                  label: 'Enter end of lease',
                                  isRequired: true,
                                ),
                                SizedBox(height: 6),
                                FormFieldWidget(
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
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    // ==========================================================
                    // Tenant Occupation
                    // ==========================================================
                    FormLabel(label: 'Occupation', isRequired: false),
                    SizedBox(height: 6),
                    FormFieldWidget(
                      controller: occupationController,
                      keyboardType: TextInputType.text,
                      hintText: 'Enter Occupation',
                      required: false,
                    ),
                    SizedBox(height: 15.0),

                    //Emergency contact
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Emergency contact Information:',
                        style: TextStyle(
                          color: AppColorsConstant.darkBlueColor,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 06),
                    // ==========================================================
                    // Next Of Kin
                    // ==========================================================
                    Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabel(label: 'Enter Name', isRequired: true),
                          SizedBox(height: 6),
                          FormFieldWidget(
                            controller: emergencyContactNameController,
                            keyboardType: TextInputType.text,
                            required: true,
                            hintText: 'Enter Name',
                            customValidator: validateUserName,
                          ),
                          SizedBox(height: 15.0),
                          FormLabel(
                            label: 'Enter Phone Number(07...)',
                            isRequired: true,
                          ),
                          SizedBox(height: 6),
                          FormFieldWidget(
                            controller: emergencyContactPhoneController,
                            keyboardType: TextInputType.text,
                            required: false,
                            hintText: 'Phone Number',
                            customValidator: validatePhoneNumber,
                          ),
                          SizedBox(height: 15.0),
                          FormLabel(label: 'Email Address', isRequired: false),
                          SizedBox(height: 6),
                          FormFieldWidget(
                            controller: emergencyContactEmailController,
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            hintText: 'Email',
                            required: false,
                          ),
                          SizedBox(height: 15.0),
                          FormLabel(label: 'Relationship', isRequired: false),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
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

                          // FormFieldWidget(
                        ],
                      ),
                    ),

                    SizedBox(height: 25.0),
                    // ==========================================================
                    // SUBMIT BUTTON
                    // ==========================================================
                    ColorButtonWidget(
                      onPressedCallBack: () async {
                        if (isUpdateMode) {
                          await updateTenantMethod(context, currentUser);
                        } else {
                          await addTenantMethod(context, currentUser);
                        }
                      },
                      buttonTitle: isUpdateMode
                          ? 'Update Tenant'
                          : 'Add Tenant',
                      fontSize: 14,
                      buttonColor: AppColorsConstant.greenColor,
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
