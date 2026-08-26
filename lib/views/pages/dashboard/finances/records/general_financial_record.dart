import 'dart:developer';
import 'package:anyamar/data/models/date_format/date_format_model.dart';
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/data/services/db_finances_service.dart';
import 'package:anyamar/utils/loader/lazy_loader_util.dart';
import 'package:anyamar/utils/snackbar/snackbar_util.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/models/enums/financial_record_nature.dart';
import 'package:anyamar/data/models/enums/financial_record_types.dart';
import 'package:anyamar/views/forms/dashboard_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:flutter/services.dart';

class AddGeneralFinancialRecord extends StatelessWidget {
  final FinancialRecord? financialRecord;
  const AddGeneralFinancialRecord({super.key, this.financialRecord});
  @override
  Widget build(BuildContext context) {
    return DashboardForm(
      form: GeneralFinancialRecordForm(financialRecord: financialRecord),
    );
  }
}

class GeneralFinancialRecordForm extends ConsumerStatefulWidget {
  final FinancialRecord? financialRecord;

  const GeneralFinancialRecordForm({super.key, this.financialRecord});

  @override
  ConsumerState<GeneralFinancialRecordForm> createState() =>
      _GeneralFinancialRecordFormState();
}

class _GeneralFinancialRecordFormState
    extends ConsumerState<GeneralFinancialRecordForm> {
  FinancialRecordNature? financialNatureType;
  FinancialRecordTypes? financialRecordType;
  String? tenantName;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController datePaidController = TextEditingController();
  final TextEditingController paymentByController = TextEditingController();
  DateTime? paymentDate;
  final _formKey = GlobalKey<FormState>();
  bool get isUpdateMode => widget.financialRecord != null;
  List<Tenant> myTenants = [];

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final record = widget.financialRecord;
    // ADD MODE
    if (record == null) {
      return;
    }
    // UPDATE MODE
    amountController.text = record.amountPaid.toString();
    datePaidController.text = formatPrettyDate(record.datePaid);
    paymentByController.text = record.paymentBy['personName']?.toString() ?? '';
    paymentDate = record.datePaid;
    financialNatureType = record.recordNature;
    financialRecordType = record.recordType;
    tenantName = record.paymentBy['personName'];
  }

  @override
  void dispose() {
    amountController.dispose();
    datePaidController.dispose();
    paymentByController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    myTenants = ref.read(
      userInformationProvider.select((state) => state.tenants),
    );
    log('myTenants : ${myTenants.map((e) => e.tenantName)}');

    return FormPages(
      pageTitle: isUpdateMode
          ? 'Update Financial Record'
          : 'Add Financial Record',
      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ============================================================
              // FINANCIAL RECORD NATURE
              // ============================================================
              FormLabel(label: 'Financial record nature', isRequired: true),
              const SizedBox(height: 6),
              DropdownButtonFormField<FinancialRecordNature>(
                initialValue: financialNatureType,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hint: Text(
                  'Select',
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
                ),
                decoration: CustomInputDecoration.textInputDecoration(),
                items: FinancialRecordNature.values.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type.label));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    financialNatureType = value;
                    // The financial type depends on the nature.
                    // Therefore clear it whenever nature changes.
                    financialRecordType = null;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Select a type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // ============================================================
              // FINANCIAL RECORD TYPE
              // ============================================================
              if (financialNatureType != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(label: 'Financial record type', isRequired: true),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<FinancialRecordTypes>(
                      initialValue: financialRecordType,
                      hint: Text(
                        'Select type',
                        style: CustomInputDecoration.textInputDecoration()
                            .hintStyle,
                      ),
                      decoration: CustomInputDecoration.textInputDecoration(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      items: FinancialRecordTypes.values
                          .where((type) => type.nature == financialNatureType)
                          .map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.label),
                            );
                          })
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          financialRecordType = value;
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
                    // ======================================================
                    // AMOUNT
                    // ======================================================
                    FormLabel(label: 'Amount in Ksh', isRequired: true),
                    const SizedBox(height: 6),
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
                      needsValidation: true,
                      hintText: 'Enter Amount',
                      prefix: Text(
                        'Ksh ',
                        style: CustomTextStyles.cardDescriptionStyle,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // ======================================================
                    // DATE OF PAYMENT
                    // ======================================================
                    FormLabel(label: 'Date of payment', isRequired: true),
                    const SizedBox(height: 6),
                    FormFieldWidget(
                      controller: datePaidController,
                      hintText: 'Enter date of payment',
                      needsValidation: true,
                      onPressedCallBack: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2010, 1, 1),
                          lastDate: DateTime(2090, 1, 1),
                          initialDate: paymentDate ?? DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            paymentDate = selectedDate;
                            datePaidController.text = formatPrettyDate(
                              selectedDate,
                            );
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    // ======================================================
                    // PAYMENT BY
                    // ======================================================
                    FormLabel(label: 'Payment By', isRequired: true),
                    const SizedBox(height: 6),
                    financialRecordType != null &&
                            (financialRecordType == FinancialRecordTypes.rent ||
                                financialRecordType ==
                                    FinancialRecordTypes.rentdeposit) &&
                            myTenants.isNotEmpty
                        ? DropdownButtonFormField<String>(
                            initialValue:
                                myTenants.any(
                                  (tenant) => tenant.tenantName == tenantName,
                                )
                                ? tenantName
                                : null,
                            hint: Text(
                              'Select tenant',
                              style: CustomInputDecoration.textInputDecoration()
                                  .hintStyle,
                            ),
                            decoration:
                                CustomInputDecoration.textInputDecoration(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            items: myTenants.map((tt) {
                              return DropdownMenuItem(
                                value: tt.tenantName,
                                child: Text(tt.tenantName),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                paymentByController.text = value ?? '';
                                tenantName = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Select an option';
                              }
                              return null;
                            },
                          )
                        : FormFieldWidget(
                            controller: paymentByController,
                            hintText: 'Enter Name',
                            needsValidation: true,
                          ),
                  ],
                ),
              const SizedBox(height: 20),
              // ============================================================
              // SUBMIT
              // ============================================================
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (isUpdateMode) {
                    await updateFinancialRecord(context, currentUser);
                  } else {
                    await createFinancialRecord(context, currentUser);
                  }
                },
                fontSize: 12,
                buttonTitle: isUpdateMode ? 'Update Record' : 'Add Record',
                buttonColor: AppColorsConstant.greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ========================================================================
  // CREATE
  // ========================================================================

  Future<void> createFinancialRecord(
    BuildContext context,
    User? currentUser,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (financialNatureType == null ||
        financialRecordType == null ||
        paymentDate == null) {
      displaySnackBar(
        context,
        'Enter all required fields',
        AppColorsConstant.redColor,
      );

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
    final amount = double.tryParse(amountController.text.trim());
    if (amount == null) {
      displaySnackBar(
        context,
        'Enter a valid amount',
        AppColorsConstant.redColor,
      );

      return;
    }
    final lazyLoader = LazyLoader(context: context);
    lazyLoader.showLoader();
    final db = DbFinancesService();
    final financialRecord = FinancialRecord(
      datePaid: paymentDate!,
      amountPaid: amount,
      recordType: financialRecordType!,
      paymentBy: {'personName': paymentByController.text.trim()},
      lastUpdatedDate: DateTime.now(),
      recordNature: financialNatureType!,
      userId: currentUser.uid,
    );
    try {
      final newRecord = await db.addRecord(financialRecord);
      if (newRecord != null) {
        // update Riverpod state.
        ref.read(userInformationProvider.notifier).appendFinances(newRecord);
      }
      if (!mounted) return;
      displaySnackBar(
        context,
        'Record added successfully',
        AppColorsConstant.greenColor,
      );
    } catch (e, stackTrace) {
      log('Error adding financial record: $e', stackTrace: stackTrace);
      if (!mounted) return;
      displaySnackBar(
        context,
        'Error: $e occurred when adding the record',
        AppColorsConstant.redColor,
      );
    } finally {
      if (mounted) {
        lazyLoader.hideLoader();
        Navigator.pop(context);
      }
    }
  }

  // ========================================================================
  // UPDATE
  // ========================================================================
  Future<void> updateFinancialRecord(
    BuildContext context,
    User? currentUser,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (financialNatureType == null ||
        financialRecordType == null ||
        paymentDate == null) {
      displaySnackBar(
        context,
        'Enter all required fields',
        AppColorsConstant.redColor,
      );

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

    final amount = double.tryParse(amountController.text.trim());

    if (amount == null) {
      displaySnackBar(
        context,
        'Enter a valid amount',
        AppColorsConstant.redColor,
      );

      return;
    }

    final lazyLoader = LazyLoader(context: context);

    lazyLoader.showLoader();

    final db = DbFinancesService();

    final updatedFinancialRecord = widget.financialRecord!.copyWith(
      datePaid: paymentDate!,
      amountPaid: amount,
      recordType: financialRecordType!,
      paymentBy: {'personName': paymentByController.text.trim()},
      recordNature: financialNatureType!,
      lastUpdatedDate: DateTime.now(),
      userId: currentUser.uid,
    );

    try {
      final updatedRecord = await db.updateRecord(updatedFinancialRecord);
      ref.read(userInformationProvider.notifier).updateFinance(updatedRecord);
      if (!mounted) return;
      displaySnackBar(
        context,
        'Record updated successfully',
        AppColorsConstant.greenColor,
      );
    } catch (e, stackTrace) {
      log('Error updating financial record: $e', stackTrace: stackTrace);

      if (!mounted) return;

      displaySnackBar(
        context,
        'Error: $e occurred when updating the record',
        AppColorsConstant.redColor,
      );
    } finally {
      if (mounted) {
        lazyLoader.hideLoader();
        Navigator.pop(context);
      }
    }
  }
}

// class GeneralFinancialRecordForm extends ConsumerStatefulWidget {
//   final FinancialRecord? financialRecord;
//   const GeneralFinancialRecordForm({super.key, this.financialRecord});

//   @override
//   ConsumerState<GeneralFinancialRecordForm> createState() =>
//       _GeneralFinancialRecordFormState();
// }

// class _GeneralFinancialRecordFormState
//     extends ConsumerState<GeneralFinancialRecordForm> {
//   FinancialRecordNature? financialNatureType;
//   FinancialRecordTypes? financialRecordType;
//   TextEditingController amountController = TextEditingController();
//   TextEditingController datePaidController = TextEditingController();
//   TextEditingController paymentByController = TextEditingController();
//   DateTime? paymentDate;
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     amountController.dispose();
//     datePaidController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final financialnature = widget.financialRecord != null
//         ? widget.financialRecord!.recordNature
//         : ref.watch(financialRecordNatureProvider);
//     final currentUser = ref.watch(authServiceProvider).currentUser;
//     paymentDate = widget.financialRecord?.datePaid;
//     financialRecordType = widget.financialRecord?.recordType;

//     return FormPages(
//       pageTitle: widget.financialRecord != null
//           ? 'Update Financial Record'
//           : 'Add Financial Record',
//       form: Form(
//         key: _formKey,
//         child: Align(
//           alignment: Alignment.topLeft,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 30.0),
//               FormLabel(label: 'Financial record nature', isRequired: true),
//               SizedBox(height: 6),
//               //Expense or revenue?
//               DropdownButtonFormField<FinancialRecordNature>(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,

//                 hint: Text(
//                   'Select',
//                   style: CustomInputDecoration.textInputDecoration().hintStyle,
//                 ),
//                 initialValue: financialnature,
//                 decoration: CustomInputDecoration.textInputDecoration(),

//                 items: FinancialRecordNature.values.map((type) {
//                   return DropdownMenuItem(value: type, child: Text(type.label));
//                 }).toList(),

//                 onChanged: (value) {
//                   setState(() {
//                     financialNatureType = value;
//                   });

//                   //clear current record
//                   ref
//                       .read(financialRecordNatureProvider.notifier)
//                       .clearNature();
//                   //fetch new record
//                   ref
//                       .read(financialRecordNatureProvider.notifier)
//                       .fetchNature(value!);
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return ' Select a type';
//                   }
//                   return null;
//                 },
//               ),

//               SizedBox(height: 15),
//               if (financialnature != null)
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     FormLabel(label: 'Financial record type', isRequired: true),
//                     SizedBox(height: 6),
//                     //? ----- Financial Record type -----
//                     DropdownButtonFormField<FinancialRecordTypes>(
//                       initialValue: financialRecordType,
//                       hint: Text(
//                         'Select type',
//                         style: CustomInputDecoration.textInputDecoration()
//                             .hintStyle,
//                       ),
//                       decoration: CustomInputDecoration.textInputDecoration(),
//                       autovalidateMode: AutovalidateMode.onUserInteraction,

//                       items: financialnature == FinancialRecordNature.expense
//                           ? FinancialRecordTypes.values
//                                 .where(
//                                   (f) =>
//                                       f.nature.label ==
//                                       FinancialRecordNature.expense.label,
//                                 )
//                                 .map((type) {
//                                   return DropdownMenuItem(
//                                     value: type,
//                                     child: Text(type.label),
//                                   );
//                                 })
//                                 .toList()
//                           : FinancialRecordTypes.values
//                                 .where(
//                                   (f) =>
//                                       f.nature.label ==
//                                       FinancialRecordNature.revenue.label,
//                                 )
//                                 .map((type) {
//                                   return DropdownMenuItem(
//                                     value: type,
//                                     child: Text(type.label),
//                                   );
//                                 })
//                                 .toList(),
//                       onChanged: (value) {
//                         //todo:fetch current type using riverpod
//                         setState(() {
//                           financialRecordType = value;
//                         });
//                       },
//                       validator: (value) {
//                         if (value == null) {
//                           return ' Select an option';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 15),
//                     //todo: ksh prefix
//                     FormLabel(label: 'Amount in ksh', isRequired: true),
//                     SizedBox(height: 6),

//                     FormFieldWidget(
                    
//                       controller: amountController,
//                       keyboardType: TextInputType.number,
//                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                       needsValidation: true,
//                       hintText: 'Enter Amount ',
//                       prefix: Text(
//                         'Ksh ',
//                         style: CustomTextStyles.cardDescriptionStyle,
//                       ),
//                     ),

//                     SizedBox(height: 15.0),
//                     //Date of payment
//                     FormLabel(label: 'Date of payment', isRequired: true),
//                     SizedBox(height: 6),
//                     FormFieldWidget(
                     
//                       controller: datePaidController,
//                       hintText: 'Enter date of payment',
//                       needsValidation: true,
//                       onPressedCallBack: () async {
//                         DateTime? selectedDate = await showDatePicker(
//                           context: context,
//                           firstDate: DateTime(2010, 1, 1),
//                           lastDate: DateTime(2090, 1, 1),
//                         );
//                         if (selectedDate != null) {
//                           setState(() {
//                             datePaidController.text = formatPrettyDate(
//                               selectedDate,
//                             );
//                             paymentDate = selectedDate;
//                           });
//                         }
//                       },
//                     ),
//                     SizedBox(height: 15.0),
//                     //Payment By
//                     FormLabel(label: 'Payment By', isRequired: true),
//                     SizedBox(height: 6),
//                     FormFieldWidget(
//                       controller: paymentByController,
//                       initialValue:
//                           widget.financialRecord?.paymentBy['personName'],
//                       hintText: 'Enter Name ',
//                       needsValidation: true,
//                     ),
//                   ],
//                 ),
//               SizedBox(height: 20.0),
//               //Submit button
//               ColorButtonWidget(
//                 onPressedCallBack: () async {
//                   widget.financialRecord == null
//                       ? await createFinancialRecord(context, currentUser)
//                       : await updateFinancialRecord(context, currentUser);
//                 },
//                 buttonTitle: 'Submit',
//                 buttonColor: AppColorsConstant.greenColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> createFinancialRecord(
//     BuildContext context,
//     User? currentUser,
//   ) async {
//     if (_formKey.currentState!.validate() &&
//         financialNatureType != null &&
//         paymentDate != null &&
//         financialRecordType != null) {
//       LazyLoader lazyLoader = LazyLoader(context: context);
//       lazyLoader.showLoader();
//       final db = DbFinancesService();

//       FinancialRecord financialRecord = FinancialRecord(
//         datePaid: paymentDate!,
//         amountPaid: double.parse(amountController.text.trim()),
//         recordType: financialRecordType!,
//         paymentBy: {'personName': paymentByController.text.trim()},
//         recordNature: financialNatureType!,
//         lastUpdatedDate: DateTime.now(),
//         userId: currentUser!.uid,
//       );
//       //Add financial record to database
//       try {
//         final newRecord = await db.addRecord(financialRecord);
//         if (newRecord != null) {
//           ref.read(userInformationProvider.notifier).appendFinances(newRecord);
//           displaySnackBar(
//             context,
//             'Record added successfully',
//             AppColorsConstant.greenColor,
//           );
//         }
//       } catch (e) {
//         displaySnackBar(
//           context,
//           'Error : $e occured when adding the record, try again later',
//           AppColorsConstant.redColor,
//         );
//       } finally {
//         lazyLoader.hideLoader();
//         Navigator.pop(context);
//       }
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Enter required fields')));
//     }
//   }

//   Future<void> updateFinancialRecord(
//     BuildContext context,
//     User? currentUser,
//   ) async {
//     if (_formKey.currentState!.validate() &&
//         financialNatureType != null &&
//         paymentDate != null &&
//         financialRecordType != null) {
//       LazyLoader lazyLoader = LazyLoader(context: context);
//       lazyLoader.showLoader();
//       final db = DbFinancesService();

//       FinancialRecord financialRecord = widget.financialRecord!.copyWith(
//         datePaid: paymentDate!,
//         amountPaid: double.parse(amountController.text.trim()),
//         recordType: financialRecordType!,
//         paymentBy: {'personName': paymentByController.text.trim()},
//         recordNature: financialNatureType!,
//         lastUpdatedDate: DateTime.now(),
//         userId: currentUser!.uid,
//       );
//       //Update financial record to database
//       try {
//         final updatedRecord = await db.updateRecord(financialRecord);

//         ref.read(userInformationProvider.notifier).updateFinance(updatedRecord);
//         displaySnackBar(
//           context,
//           'Record added successfully',
//           AppColorsConstant.greenColor,
//         );
//       } catch (e) {
//         displaySnackBar(
//           context,
//           'Error : $e occured when adding the record, try again later',
//           AppColorsConstant.redColor,
//         );
//       } finally {
//         lazyLoader.hideLoader();
//         Navigator.pop(context);
//       }
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Enter required fields')));
//     }
//   }
// }
