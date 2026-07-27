import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/data_sets/properties.dart';
import 'package:anyamar/data/data_sets/units.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/data/providers/selected_file_notifier_provider.dart';
import 'package:anyamar/views/forms/dashboard_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/file_picker/file_picked_widget.dart';
import 'package:anyamar/views/reusable_widgets/file_picker/file_picker_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';

class TenantForm extends ConsumerStatefulWidget {
  const TenantForm({super.key});

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
  TextEditingController emergencyContactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    emergencyContactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pickedFile = ref.watch(selectedFileProvider);
    return FormPages(
      pageTitle: 'Add Tenant',

      form: Form(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),

              //----- Name-----
              FormLabel(label: 'Full name', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: tenantNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter full name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Tenant\'s name';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15.0),

              //Email
              FormLabel(label: 'Email address'),
              SizedBox(height: 6),
              TextFormField(
                controller: tenantEmailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  //todo: email only
                  // FilteringTextInputFormatter.allow(filterPattern)
                ],
                keyboardType: TextInputType.emailAddress,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter email address',
                ),
              ),
              SizedBox(height: 15.0),
              //Phone number
              FormLabel(label: 'Phone number', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: tenantPhoneController,
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter Phone number (07...)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Tenant\'s phone number ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              //National ID / passport
              FormLabel(
                label: 'National ID / Passport number',
                isRequired: true,
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: tenantNationalIdController,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter National ID or passport number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Tenant\'s national Id/ passport';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),

              //----- Select unit -----
              FormLabel(label: 'Occupied unit', isRequired: true),
              SizedBox(height: 6),
              //todo: units belonging to a specific user
              DropdownButtonFormField<Unit>(
                hint: Text('Select Unit'),
                decoration: CustomInputDecoration.textInputDecoration(),
                autovalidateMode: AutovalidateMode.onUserInteraction,

                items: tempunits.map((unit) {
                  //get Property name
                  Property property = properties
                      .where((p) => p.propertyId == unit.propertyId)
                      .first;
                  //todo: change propertyId to property name
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(
                      unit.unitName != null
                          ? '${unit.unitName}, ${property.propertyName}'
                          : '${unit.unitId}, ${property.propertyName})',
                    ),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Select the unit where the tenant resides';
                  }
                  return null;
                },
                onChanged: (value) {
                  // ref.read(selectedPropertyProvider.notifier).state = value;
                },
              ),

              SizedBox(height: 15.0),
              //Start and end of lease
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
                        TextFormField(
                          controller: leaseStartController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          enabled: true,
                          decoration: CustomInputDecoration.textInputDecoration(
                            hintText: 'Select date',
                          ),
                          onTap: () => showDatePicker(
                            context: context,
                            firstDate: DateTime(2010, 1, 1),
                            lastDate: DateTime(2090, 1, 1),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter the lease start date';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  //End of lease
                  Expanded(
                    child: Column(
                      children: [
                        FormLabel(label: 'Enter end of lease'),
                        SizedBox(height: 6),
                        TextFormField(
                          controller: leaseEndController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          enabled: true,
                          decoration: CustomInputDecoration.textInputDecoration(
                            hintText: 'Select date',
                          ),
                          onTap: () => showDatePicker(
                            context: context,
                            firstDate: DateTime(2010, 1, 1),
                            lastDate: DateTime(2090, 1, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              //Occupation
              FormLabel(label: 'Occupation', isRequired: false),
              SizedBox(height: 6),
              TextFormField(
                controller: occupationController,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter Occupation',
                ),
              ),
              SizedBox(height: 15.0),

              //Emergency contact
              FormLabel(label: 'Emergency contact (07...)', isRequired: false),
              SizedBox(height: 6),
              TextFormField(
                controller: emergencyContactController,
                keyboardType: TextInputType.text,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter Emergency contact',
                ),
              ),
              SizedBox(height: 15.0),

              //Upload lease agreement
              FormLabel(label: 'Lease agreement', isRequired: false),
              SizedBox(height: 6),
              pickedFile != null
                  ? FilePickedWidget(pickedFile: pickedFile)
                  : FilePickerWidget(
                      isImage: false,
                      uploadText: 'Click here to upload the lease agreement',
                    ),
              //End of lease
              SizedBox(height: 35.0),
              //? ------ Submit button ------
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (_formKey.currentState!.validate()) {}
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enter required fields')),
                  );
                  //todo: when complete...add take to add units form
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
}

class AddTenant extends StatelessWidget {
  const AddTenant({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(form: TenantForm());
  }
}
