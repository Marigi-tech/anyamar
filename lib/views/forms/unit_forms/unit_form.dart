import 'package:anyamar/constants/commons.dart';
import 'package:flutter/services.dart';
import 'package:anyamar/data/data_sets/properties.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/views/forms/dashboard_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';

class UnitForm extends StatefulWidget {
  const UnitForm({super.key});

  @override
  State<UnitForm> createState() => _UnitFormState();
}

class _UnitFormState extends State<UnitForm> {
  TextEditingController unitNameController = TextEditingController();
  TextEditingController propertyNameController = TextEditingController();
  TextEditingController floorController = TextEditingController();

  Color? textColor;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    unitNameController.dispose();
    propertyNameController.dispose();
    floorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormPages(
      pageTitle: 'Add Unit',

      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              //----- Unit Name-----
              FormLabel(label: 'Unit name / number', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: unitNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter unit name / number',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the unit\'s name / number,  or assign a name to it for easier record keeping';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15.0),

              //----- Select property  -----
              //todo: select from a user specific list
              FormLabel(label: 'Property ', isRequired: true),
              SizedBox(height: 6),
              DropdownButtonFormField<Property>(
                hint: Text(
                  'Select property',
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomInputDecoration.textInputDecoration(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a property option';
                  }
                  return null;
                },

                items: properties.map((property) {
                  return DropdownMenuItem(
                    value: property,
                    child: Text(property.propertyName),
                  );
                }).toList(),
                onChanged: (value) {
                  // ref.read(selectedPropertyProvider.notifier).state = value;
                },
              ),
              SizedBox(height: 15.0),
              //Enter floor
              FormLabel(label: 'Floor number', isRequired: false),
              SizedBox(height: 6),
              TextFormField(
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter Floor number',
                ),
              ),

              //? ----- Enter Image -----
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

class AddUnit extends StatelessWidget {
  const AddUnit({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(form: UnitForm());
  }
}
