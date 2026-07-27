import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/models/enums/financial_record_nature.dart';
import 'package:anyamar/data/models/enums/financial_record_types.dart';
import 'package:anyamar/data/providers/form_providers/financial_record_nature_provider.dart';
import 'package:anyamar/views/forms/dashboard_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:flutter/services.dart';

class AddGeneralFinancialRecord extends StatelessWidget {
  const AddGeneralFinancialRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(form: GeneralFinancialRecordForm());
  }
}

class GeneralFinancialRecordForm extends ConsumerStatefulWidget {
  const GeneralFinancialRecordForm({super.key});

  @override
  ConsumerState<GeneralFinancialRecordForm> createState() =>
      _GeneralFinancialRecordFormState();
}

class _GeneralFinancialRecordFormState
    extends ConsumerState<GeneralFinancialRecordForm> {
  TextEditingController financialNature = TextEditingController();
  TextEditingController financialType = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController datePaidController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    financialNature.dispose();
    financialType.dispose();
    amountController.dispose();
    datePaidController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final financialnature = ref.watch(financialRecordNatureProvider);
    return FormPages(
      pageTitle: 'Add Financial Record',

      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              FormLabel(label: 'Financial record nature', isRequired: true),
              SizedBox(height: 6),
              //Expense or revenue?
              DropdownButtonFormField<FinancialRecordNature>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hint: Text(
                  'Select',
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
                ),
                initialValue: financialnature,
                decoration: CustomInputDecoration.textInputDecoration(),

                items: FinancialRecordNature.values.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type.label));
                }).toList(),

                onChanged: (value) {
                  //clear current record
                  ref
                      .read(financialRecordNatureProvider.notifier)
                      .clearNature();
                  //fetch new record
                  ref
                      .read(financialRecordNatureProvider.notifier)
                      .fetchNature(value!);
                },
                validator: (value) {
                  if (value == null) {
                    return ' Select a type';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),
              if (financialnature != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FormLabel(label: 'Financial record type', isRequired: true),
                    SizedBox(height: 6),
                    //? ----- Financial Record type -----
                    DropdownButtonFormField<FinancialRecordTypes>(
                      hint: Text(
                        'Select type',
                        style: CustomInputDecoration.textInputDecoration()
                            .hintStyle,
                      ),
                      decoration: CustomInputDecoration.textInputDecoration(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      items: financialnature == FinancialRecordNature.expense
                          ? FinancialRecordTypes.values
                                .where(
                                  (f) =>
                                      f.nature.label ==
                                      FinancialRecordNature.expense.label,
                                )
                                .map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(type.label),
                                  );
                                })
                                .toList()
                          : FinancialRecordTypes.values
                                .where(
                                  (f) =>
                                      f.nature.label ==
                                      FinancialRecordNature.revenue.label,
                                )
                                .map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(type.label),
                                  );
                                })
                                .toList(),
                      onChanged: (value) {
                        //todo:fetch current type using riverpod
                      },
                      validator: (value) {
                        if (value == null) {
                          return ' Select an option';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    //todo: ksh prefix
                    FormLabel(label: 'Amount in ksh', isRequired: true),
                    SizedBox(height: 6),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: CustomInputDecoration.textInputDecoration(
                        hintText: 'Enter Amount ',
                        prefix: Text(
                          'Ksh ',
                          style: CustomTextStyles.cardDescriptionStyle,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter amount';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15.0),
                    //Date of payment
                    FormLabel(label: 'Date of payment', isRequired: true),
                    SizedBox(height: 6),
                    TextFormField(
                      controller: datePaidController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      enabled: true,
                      decoration: CustomInputDecoration.textInputDecoration(
                        hintText: 'Enter date of payment',
                      ),
                      onTap: () => showDatePicker(
                        context: context,
                        firstDate: DateTime(2010, 1, 1),
                        lastDate: DateTime(2090, 1, 1),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Date';
                        }
                        return null;
                      },
                    ),
                  ],
                ),

              SizedBox(height: 35.0),
              //? ------ Submit button ------
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (_formKey.currentState!.validate()) {}
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
