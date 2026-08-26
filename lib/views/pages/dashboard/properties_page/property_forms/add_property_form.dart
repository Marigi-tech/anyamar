import 'dart:developer';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/users/person/person.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/data/services/db_property_service.dart';
import 'package:anyamar/utils/loader/lazy_loader_util.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_field_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';

class AddPropertyForm extends ConsumerStatefulWidget {
  const AddPropertyForm({super.key});

  @override
  ConsumerState<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends ConsumerState<AddPropertyForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController floorsController = TextEditingController();
  TextEditingController propertyManagerNameController = TextEditingController();
  TextEditingController propertyManagerEmailController =
      TextEditingController();
  TextEditingController propertyManagerPhoneController =
      TextEditingController();
  bool? isAgency;
  Color? textColor;
  final _formKey = GlobalKey<FormState>();

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
    popPage() {
      Navigator.pop(context);
    }

    return FormPages(
      pageTitle: 'Add Property',

      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30.0),
              //Property Name
              FormLabel(label: 'Property name', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: nameController,
                hintText: 'Enter property name',
              ),
              SizedBox(height: 15.0),
              //Property Location
              FormLabel(label: 'Location', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: locationController,
                hintText: 'Enter location',
              ),
              SizedBox(height: 15.0),
              //todo: Agency boolean

              //Number of floors
              FormLabel(label: 'Number of floors', isRequired: false),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: floorsController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hintText: 'Enter number of floors',
              ),
              SizedBox(height: 15.0),
              //Agency / Property Manager
              FormLabel(label: 'Property manager', isRequired: true),
              SizedBox(height: 6),
              DropdownButtonFormField<bool>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hint: Text(
                  'Select',
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
                ),
                initialValue: false,
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
              //Property Manager Information
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
                            hintText: 'Enter name',
                            controller: propertyManagerNameController,
                            needsValidation: true,
                          ),
                          SizedBox(height: 10),
                          //Property manager Phone
                          FormLabel(label: 'Phone number', isRequired: false),
                          SizedBox(height: 8),
                          FormFieldWidget(
                            hintText: 'Enter phone number',
                            controller: propertyManagerPhoneController,
                            needsValidation: false,
                          ),
                          SizedBox(height: 10),
                          //Property manager Email
                          FormLabel(label: 'Email address', isRequired: false),
                          SizedBox(height: 8),
                          FormFieldWidget(
                            hintText: 'Enter email address',
                            controller: propertyManagerEmailController,
                            needsValidation: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 35.0),
              //Submit button
              ColorButtonWidget(
                onPressedCallBack: () async {
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

                      propertyManager: {
                        'personName': propertyManager.personName,
                        'personEmail': propertyManager.personEmail,
                        'personPhone': propertyManager.personPhone,
                        'isAgency': propertyManager.isAgency,
                      },
                    );

                    try {
                      await db.addProperty(property);
                      ref
                          .read(userInformationProvider.notifier)
                          .appendProperty(property);

                      displaySnackBar(
                        context,
                        'Property added succesfully',
                        AppColorsConstant.greenColor,
                      );
                    } catch (e, stackTrace) {
                      log('Error adding property: $e', stackTrace: stackTrace);

                      displaySnackBar(
                        context,
                        'Error: $e',
                        AppColorsConstant.redColor,
                      );
                    } finally {
                      lazyLoader.hideLoader();
                      popPage();
                    }
                  }
                },
                buttonTitle: 'Submit',
                buttonColor: AppColorsConstant.greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void displaySnackBar(
    BuildContext context,
    String information,
    Color backgroundColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(information),
        duration: Duration(seconds: 1),
        showCloseIcon: true,
        closeIconColor: AppColorsConstant.whiteColor,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
