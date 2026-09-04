import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/utils/text_input_formatters/phone_number_formatter.dart';

class AddPropertyForm extends ConsumerStatefulWidget {
  final Property? currentProperty;
  final bool? isFromUnitPage;
  const AddPropertyForm({super.key, this.currentProperty, this.isFromUnitPage});

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
    return FormPages(
      pageTitle: isUpdateMode ? 'Update Property' : 'Add Property',
      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.0),
              // ========================================================
              // PROPERTY NAME
              // ========================================================
              FormLabel(label: 'Property name', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: nameController,
                hintText: 'Enter property name',
              ),
              SizedBox(height: 15.0),
              // ========================================================
              // PROPERTY LOCATION
              // ========================================================
              FormLabel(label: 'Location', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: locationController,
                hintText: 'Enter location',
              ),
              SizedBox(height: 15.0),
              // ========================================================
              // NUMBER OF FLOORS
              // ========================================================
              FormLabel(label: 'Number of floors', isRequired: false),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: floorsController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hintText: 'Enter number of floors',
                required: false,
              ),
              SizedBox(height: 15.0),
              // ========================================================
              // PROPERTY MANAGER / AGENCY
              // ========================================================
              FormLabel(label: 'Property manager', isRequired: true),
              SizedBox(height: 6),
              DropdownButtonFormField<bool>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hint: Text(
                  'Select',
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
                ),
                initialValue: isAgency,
                decoration: CustomInputDecoration.textInputDecoration(),
                items: [
                  DropdownMenuItem(value: true, child: const Text('Agency')),
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
              SizedBox(height: 15.0),
              // ============================================================
              // PROPERTY MANAGER INFORMATION
              // ============================================================
              if (isAgency != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    FormLabel(
                      label: isAgency == true
                          ? 'Agency Information'
                          : 'Manager Information',
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.only(left: 70, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Property manager name
                          FormLabel(label: 'Name', isRequired: true),
                          SizedBox(height: 8),
                          FormFieldWidget(
                            hintText: 'Enter full name',
                            controller: propertyManagerNameController,
                            customValidator: validateUserName,
                          ),
                          SizedBox(height: 10),
                          //Property manager Phone
                          FormLabel(label: 'Phone number', isRequired: false),
                          SizedBox(height: 8),
                          FormFieldWidget(
                            hintText: 'Enter phone number',
                            controller: propertyManagerPhoneController,
                            required: false,
                            customValidator: validatePhoneNumber,
                          ),
                          SizedBox(height: 10),
                          //Property manager Email
                          FormLabel(label: 'Email address', isRequired: false),
                          SizedBox(height: 8),
                          FormFieldWidget(
                            hintText: 'Enter email address',
                            controller: propertyManagerEmailController,
                            required: false,
                            customValidator: validateEmail,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 35.0),
              // ========================================================
              // SUBMIT BUTTON
              // ========================================================
              ColorButtonWidget(
                onPressedCallBack: () async {
                  isUpdateMode
                      ? await updateProperty(context, currentUser)
                      : await addProperty(context, currentUser);
                },
                buttonTitle: isUpdateMode ? 'Update Property' : 'Add Property',
                buttonColor: AppColorsConstant.greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================================
  // Add Property Method
  // ========================================================
  Future<void> addProperty(BuildContext context, User? currentUser) async {
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
        propertyName: nameController.text.trim(),
        propertyLocation: locationController.text.trim(),
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
      final List<Property> existingProperties = ref.watch(
        userInformationProvider.select((state) => state.properties),
      );
      final recordExists = existingProperties.any(
        (existingProperty) =>
            existingProperty.propertyName.trim().toLowerCase() ==
                property.propertyName.trim().toLowerCase() &&
            existingProperty.propertyLocation.trim().toLowerCase() ==
                property.propertyLocation.trim().toLowerCase() &&
            existingProperty.propertyManager?.personId ==
                property.propertyManager?.personId,
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
          await db.addProperty(property);
          ref.read(userInformationProvider.notifier).appendProperty(property);

          displaySnackBar(
            context,
            'Property added succesfully',
            AppColorsConstant.greenColor,
          );
        } catch (e, stackTrace) {
          log('Error adding property: $e', stackTrace: stackTrace);
          displaySnackBar(context, 'Error: $e', AppColorsConstant.redColor);
        } finally {
          lazyLoader.hideLoader();
          widget.isFromUnitPage == true
              ? Navigator.pop(context)
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SinglePropertyPage(property: property),
                  ),
                );
        }
      }
    }
  }

  // ========================================================
  // Update Property Method
  // ========================================================
  Future<void> updateProperty(BuildContext context, User? currentUser) async {
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
        propertyName: nameController.text.trim(),
        propertyLocation: locationController.text.trim(),
        propertyFloors: int.parse(floorsController.text.trim()),
        propertyManager: Person(
          personName: propertyManager.personName,
          personEmail: propertyManager.personEmail,
          personPhone: propertyManager.personPhone,
          isAgency: propertyManager.isAgency,
        ),
      );

      try {
        final Property? updatedProperty = await db.updateProperty(
          currentProperty,
        );
        if (updatedProperty != null) {
          ref
              .read(userInformationProvider.notifier)
              .updateProperty(updatedProperty);

          displaySnackBar(
            context,
            'Property Updated succesfully',
            AppColorsConstant.greenColor,
          );
          widget.isFromUnitPage == true
              ? Navigator.pop(context)
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SinglePropertyPage(property: updatedProperty),
                  ),
                );
        }
      } catch (e, stackTrace) {
        log('Error adding property: $e', stackTrace: stackTrace);
        displaySnackBar(context, 'Error: $e', AppColorsConstant.redColor);
      } finally {
        lazyLoader.hideLoader();
      }
    }
  }
}
