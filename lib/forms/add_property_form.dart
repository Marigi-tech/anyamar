import 'package:anyamar/commons/exports.dart';

class AddPropertyForm extends ConsumerStatefulWidget {
  final Property? currentProperty;
  final String introText;

  const AddPropertyForm({
    super.key,
    this.currentProperty,
    required this.introText,
  });

  @override
  ConsumerState<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends ConsumerState<AddPropertyForm> {
  // ============================================================
  // CONTROLLERS
  // ============================================================
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController floorsController = TextEditingController();
  TextEditingController propertyManagerNameController = TextEditingController();
  TextEditingController propertyManagerEmailController =
      TextEditingController();
  TextEditingController propertyManagerPhoneController =
      TextEditingController();
  // ============================================================
  // FORM STATE
  // ============================================================
  bool? isAgency;
  Color? textColor;
  final _formKey = GlobalKey<FormState>();
  bool get isUpdateMode => widget.currentProperty != null;
  // ============================================================
  // INIT
  // ============================================================
  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final property = widget.currentProperty;

    // ==========================================================
    // ADD MODE
    // ==========================================================
    if (property == null) {
      return;
    }
    // ==========================================================
    // UPDATE MODE
    // ==========================================================
    nameController.text = property.propertyName;
    locationController.text = property.propertyLocation;
    floorsController.text = property.propertyFloors.toString();
    propertyManagerNameController.text =
        property.propertyManager?.personName ?? '';
    propertyManagerEmailController.text =
        property.propertyManager?.personEmail ?? '';
    propertyManagerPhoneController.text =
        property.propertyManager?.personPhone ?? '';
    isAgency = property.propertyManager?.isAgency;
  }
  // ============================================================
  // RESET
  // ============================================================

  void _resetForm() {
    // Reset all form fields
    _formKey.currentState?.reset();

    // Clear controllers
    nameController.clear();
    locationController.clear();
    floorsController.clear();
    propertyManagerNameController.clear();
    propertyManagerEmailController.clear();
    propertyManagerPhoneController.clear();

    // Reset selected values
    setState(() {
      isAgency = null;
    });
  }

  // ==========================================================
  // DISPOSE MODE
  // ==========================================================
  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    floorsController.dispose();
    propertyManagerNameController.dispose();
    propertyManagerEmailController.dispose();
    propertyManagerPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    final appData = ref.watch(userInformationProvider);
    if (widget.currentProperty == null) {
      propertyManagerNameController.text = appData.appUser?.userName ?? '';
      propertyManagerEmailController.text = appData.appUser?.userEmail ?? '';
      propertyManagerPhoneController.text =
          appData.appUser?.userPhoneNumber ?? '';
      isAgency = appData.appUser?.userType == UserType.agent.label
          ? true
          : false;
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 10.0),
                FormCardWidget(
                  noOfColumnsPerRow: 3,
                  formCardTitle: 'Property Information',
                  formTitleIcon: Icons.apartment,
                  formInputs: [
                    // ========================================================
                    // PROPERTY NAME
                    // ========================================================
                    FormItemWidget(
                      label: 'Property name',
                      required: true,
                      child: FormFieldWidget(
                        controller: nameController,
                        hintText: 'Enter property name',
                      ),
                    ),
                    // ========================================================
                    // PROPERTY LOCATION
                    // ========================================================
                    FormItemWidget(
                      label: 'Location',
                      required: true,
                      child: FormFieldWidget(
                        controller: locationController,
                        hintText: 'Enter location',
                      ),
                    ),
                    // ========================================================
                    // NUMBER OF FLOORS
                    // ========================================================
                    FormItemWidget(
                      required: false,
                      label: 'Number of floors',
                      child: FormFieldWidget(
                        controller: floorsController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        hintText: 'Enter number of floors',
                        required: false,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 35.0),

                // ========================================================
                // PROPERTY MANAGEMENT INFORMATION
                // ========================================================
                FormCardWidget(
                  noOfColumnsPerRow: 2,
                  formCardTitle: 'Property manager Information',
                  formTitleIcon: Icons.person,
                  formInputs: [
                    FormItemWidget(
                      required: true,
                      label: ' Property management',
                      child: DropdownButtonFormField<bool>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hint: Text(
                          'Select',
                          style: CustomInputDecoration.textInputDecoration()
                              .hintStyle,
                        ),
                        initialValue: isAgency,
                        decoration: CustomInputDecoration.textInputDecoration(),
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: const Text('Agency'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: const Text('Individual'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            isAgency = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return ' Select an option (if you have no manager, enter your own information)';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (isAgency != null)
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: FormItemWidget(
                          required: true,
                          label: isAgency == true
                              ? 'Agency Information'
                              : 'Manager Information',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormItemWidget(
                                required: true,
                                label: 'Name',
                                child: FormFieldWidget(
                                  hintText: 'Enter full name',
                                  controller: propertyManagerNameController,
                                  customValidator: validateUserName,
                                ),
                              ),
                              SizedBox(height: 15),

                              FormItemWidget(
                                required: false,
                                label: ' Phone number',
                                child: FormFieldWidget(
                                  hintText: 'Enter phone number',
                                  controller: propertyManagerPhoneController,
                                  required: false,
                                  customValidator: validatePhoneNumber,
                                ),
                              ),
                              SizedBox(height: 15),
                              //Property manager Email
                              FormItemWidget(
                                required: false,
                                label: ' Email Address',
                                child: FormFieldWidget(
                                  hintText: 'Enter email address',
                                  controller: propertyManagerEmailController,
                                  required: false,
                                  customValidator: validateEmail,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 35.0),
                // ========================================================
                // SUBMIT BUTTON
                // ========================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //===============================
                    // RESET BUTTON
                    //================================
                    if (!isUpdateMode)
                      ElevatedButtonWidget(
                        buttonTitle: 'Reset',
                        isClear: true,
                        onButtonPressedCallBack: () async {
                          _resetForm();
                        },
                      ),
                    SizedBox(width: 10),
                    //===============================
                    // SUBMIT BUTTON
                    //================================
                    ElevatedButtonWidget(
                      buttonTitle: isUpdateMode
                          ? 'Update Property'
                          : 'Add Property',
                      buttonIcon: isUpdateMode
                          ? Icon(CupertinoIcons.pen)
                          : Icon(Icons.add),
                      onButtonPressedCallBack: () async {
                        if (isUpdateMode) {
                          await updateProperty(context, currentUser);
                        } else {
                          await addProperty(context, currentUser);
                        }
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

  // ========================================================
  // Add Property Method
  // ========================================================
  Future<void> addProperty(BuildContext context, User? currentUser) async {
    final appData = ref.watch(userInformationProvider);
    final isDarkMode = ref.watch(themeIsDarkProvider);
    Color dialogColor = isDarkMode
        ? AppColors.darkElevatedCard
        : AppColors.lightCard;
    if (_formKey.currentState!.validate()) {
      final lazyLoader = LazyLoader(context: context);
      final db = DbPropertyService();
      lazyLoader.showLoader();
      final Person propertyManager = Person(
        personName: propertyManagerNameController.text.trim(),
        personEmail: propertyManagerEmailController.text.trim(),
        personPhone: propertyManagerPhoneController.text.trim(),
        isAgency: isAgency,
      );

      final Property property = Property(
        propertyName: capitalizeFirstLetter(nameController.text.trim()),
        propertyLocation: capitalizeFirstLetter(locationController.text.trim()),
        userId: currentUser!.uid,
        propertyManager: Person(
          personName: propertyManager.personName,
          personEmail: propertyManager.personEmail,
          personPhone: propertyManager.personPhone,
          isAgency: propertyManager.isAgency,
        ),
      );
      //Check if this property already exists in database
      //location, name, manager
      final List<Property> existingProperties = appData.properties;

      final recordExists = existingProperties.any(
        (existingProperty) =>
            existingProperty.propertyName.trim().toLowerCase() ==
                property.propertyName.trim().toLowerCase() &&
            existingProperty.propertyLocation.trim().toLowerCase() ==
                property.propertyLocation.trim().toLowerCase() &&
            existingProperty.propertyManager?.personId ==
                property.propertyManager?.personId,
      );
      if (!mounted) return;
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
          // 1. Save the newproperty to Firestore.
          await db.addProperty(property);

          // 2. Update local provider state with new property.
          await ref
              .read(userInformationProvider.notifier)
              .appendProperty(property);

          // 3. Close the workspace
          ref.read(workspaceProvider.notifier).closeWorkspace();
        } catch (e, stackTrace) {
          log('Error adding property: $e', stackTrace: stackTrace);
          if (!mounted) return;
          displaySnackBar(context, 'Error: $e', dialogColor, false);
        } finally {
          lazyLoader.hideLoader();
        }
      }
    }
  }

  // ========================================================
  // Update Property Method
  // ========================================================
  Future<void> updateProperty(BuildContext context, User? currentUser) async {
    final isDarkMode = ref.watch(themeIsDarkProvider);
    Color dialogColor = isDarkMode
        ? AppColors.darkElevatedCard
        : AppColors.lightCard;
    if (_formKey.currentState!.validate() && widget.currentProperty != null) {
      final lazyLoader = LazyLoader(context: context);
      final db = DbPropertyService();
      lazyLoader.showLoader();
      final Person propertyManager = Person(
        personName: propertyManagerNameController.text.trim(),
        personEmail: propertyManagerEmailController.text.trim(),
        personPhone: propertyManagerPhoneController.text.trim(),
        isAgency: isAgency,
      );

      final Property currentProperty = widget.currentProperty!.copyWith(
        propertyName: capitalizeFirstLetter(nameController.text.trim()),
        propertyLocation: capitalizeFirstLetter(locationController.text.trim()),
        propertyFloors: int.parse(floorsController.text.trim()),
        propertyManager: Person(
          personName: capitalizeFirstLetter(propertyManager.personName),
          personEmail: propertyManager.personEmail,
          personPhone: propertyManager.personPhone,
          isAgency: propertyManager.isAgency,
        ),
      );
      try {
        // 1. Save the updated property to Firestore.
        await db.updateProperty(currentProperty);

        // 2. Update the local provider state.
        await ref
            .read(userInformationProvider.notifier)
            .updateProperty(currentProperty);

        // 3. Return to the previous workspace.
        ref.read(workspaceProvider.notifier).closeWorkspace();
      } catch (e, stackTrace) {
        // Show your error message here.
        log('Error adding property: $e', stackTrace: stackTrace);
        displaySnackBar(context, 'Error: $e', dialogColor, false);
      } finally {
        lazyLoader.hideLoader();
      }
    }
  }
}
