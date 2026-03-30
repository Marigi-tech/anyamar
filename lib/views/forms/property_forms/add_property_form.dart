import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/data_sets/properties.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/providers/selected_file_notifier_provider.dart';

import 'package:test_app/views/pages/initial_pages/form_pages.dart';
import 'package:test_app/views/reusable_widgets/buttons/button_widget.dart';
import 'package:test_app/views/reusable_widgets/file_picker/file_picked_widget.dart';
import 'package:test_app/views/reusable_widgets/file_picker/file_picker_widget.dart';
import 'package:test_app/views/reusable_widgets/form_elements/form_label.dart';
import 'package:test_app/views/reusable_widgets/form_elements/input_decoration.dart';

class AddPropertyForm extends ConsumerStatefulWidget {
  const AddPropertyForm({super.key});

  @override
  ConsumerState<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends ConsumerState<AddPropertyForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController floorsController = TextEditingController();

  Color? textColor;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    floorsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pickedFile = ref.watch(selectedFileProvider);
    return FormPages(
      pageTitle: 'Add Property',

      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              //----- Name-----
              FormLabel(label: 'Property name', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter property name',
                ),
                onChanged: (value) {
                  value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the property name / assign a name to it for easier record keeping';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15.0),

              //? ----- Location -----
              //todo: select from a list ?? maybe?
              FormLabel(label: 'Location', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: locationController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter location',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              //% Number of floors
              FormLabel(label: 'Number of floors', isRequired: false),
              SizedBox(height: 6),
              TextFormField(
                controller: floorsController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter number of floors',
                ),
              ),
              SizedBox(height: 15.0),

              SizedBox(height: 15.0),
              //? ----- Enter Image -----
              FormLabel(label: 'Property Image', isRequired: false),
              SizedBox(height: 6),
              pickedFile != null
                  ? FilePickedWidget(pickedFile: pickedFile)
                  : FilePickerWidget(isImage: true),

              SizedBox(height: 35.0),
              //? ------ Submit button ------
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (_formKey.currentState!.validate()) {
                    properties.toList().add(
                      Property(
                        propertyId: '005',
                        propertyName: nameController.value.text,
                        propertyLocation: locationController.value.text,
                        propertyImage: pickedFile?.path,
                        propertyManager: '',
                      ),
                    );

                    //Enter data in list
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name: ${nameController.value.text} '),
                            Text('Location: ${locationController.value.text} '),
                            Text(
                              'Number of floors: ${floorsController.value.text} ',
                            ),
                            if (pickedFile != null)
                              FilePickedWidget(pickedFile: pickedFile),
                          ],
                        ),
                      ),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enter required fields')),
                  );
                  //todo: when complete...add take to add units form
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => WidgetTree()),
                  // );
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
