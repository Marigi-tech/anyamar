import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_card_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_item_widget.dart';

class EndTenantLeaseForm extends ConsumerStatefulWidget {
  final Unit? unit;
  final Tenant? tenant;
  const EndTenantLeaseForm({super.key, this.unit, this.tenant});

  @override
  ConsumerState<EndTenantLeaseForm> createState() => _EndTenantLeaseFormState();
}

class _EndTenantLeaseFormState extends ConsumerState<EndTenantLeaseForm> {
  TextEditingController leaseEndController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  DateTime? leaseEnd;
  Tenant? tenant;
  Unit? unit;
  List<Tenant> tenantsList = [];

  // ============================================================
  // INIT
  // ============================================================
  @override
  void initState() {
    super.initState();

    _initializeForm();
  }

  void _initializeForm() {
    leaseEnd = tenant?.endOfLease;
    tenant = widget.tenant;
    unit = widget.unit;
  }
  // ============================================================
  // DISPOSE
  // ============================================================

  void _resetForm() {
    // Reset all form fields
    _formKey.currentState?.reset();
    leaseEndController.clear();
    // Reset selected values
    setState(() {
      leaseEnd = null;
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
        leaseEnd = parsedDate;
      });

      log('datePaid UPDATED: $leaseEnd ');
    } catch (e) {
      log('Could not parse payment date "$value": $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    final appData = ref.watch(userInformationProvider);
    final units = appData.units.toList();
    final tenants = appData.tenants.toList();

    tenantsList = widget.tenant == null
        ? //retrieve tenant from unit
          widget.unit != null
              ? tenants
                    .where((tenant) => tenant.unitId == widget.unit?.unitId)
                    .toList()
              : []
        : [];
    unit =
        widget.unit ??
        (widget.tenant != null
            ? units
                  .where((unit) => unit.unitId == widget.tenant?.unitId)
                  .singleOrNull
            : null);
    tenant = widget.tenant;

    return Center(
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
              FormCardWidget(
                noOfColumnsPerRow: 2,
                formCardTitle: 'Enter the date the tenant moved out',
                formTitleIcon: Icons.house,
                formInputs: [
                  // ==================================================
                  // END OF LEASE
                  // ==================================================
                  FormItemWidget(
                    label: 'Date ',
                    required: false,
                    child: FormFieldWidget(
                      controller: leaseEndController,
                      keyboardType: TextInputType.datetime,
                      hintText: 'Enter date (date / month / year)',
                      required: true,
                      inputFormatters: [DateInputFormatter()],
                      onPressedCallBack: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          helpText: 'Select end of lease',
                        );

                        if (pickedDate != null) {
                          final formattedDate =
                              '${pickedDate.day.toString().padLeft(2, '0')}/'
                              '${pickedDate.month.toString().padLeft(2, '0')}/'
                              '${pickedDate.year}';

                          leaseEndController.text = formattedDate;
                          _updateDatePaid(formattedDate, true);
                        }
                      },
                      onChangedCallBack: (value) {
                        _updateDatePaid(value, true);
                      },
                    ),
                  ),
                  // ==================================================
                  // Select Tenant from a list of tenants
                  // ==================================================
                  tenantsList.isNotEmpty && tenant == null
                      ? FormItemWidget(
                          label: 'Tenant',
                          required: true,
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Select tenant'),
                            initialValue: '',
                            decoration:
                                CustomInputDecoration.textInputDecoration(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            items: tenantsList
                                // .where((tenant) => tenant.isActive == true) //todo : remove the quotes
                                .map((tenant) {
                                  return DropdownMenuItem<String>(
                                    value: tenant.tenantId,
                                    child: Text('${tenant.unitName}'),
                                  );
                                })
                                .toList(),

                            validator: (value) {
                              if (value == null) {
                                return 'Select a tenant';
                              }
                              return null;
                            },

                            onChanged: (tenantId) {
                              Tenant? tenann = tenants
                                  .where(
                                    (tenant) => tenant.tenantId == tenantId,
                                  )
                                  .singleOrNull;

                              log(
                                'This is the selected tenant: ${tenann?.tenantName}',
                              );

                              setState(() {
                                tenant = tenann;
                              });
                            },
                          ),
                        )
                      : SizedBox.shrink(),
                ],
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
                    buttonTitle: 'Update Tenant',
                    buttonIcon: Icon(CupertinoIcons.pen),

                    onButtonPressedCallBack: () async {
                      await endLeaseMethod(context, currentUser);
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
  // End lease
  // ==========================================================
  Future<void> endLeaseMethod(BuildContext context, User? currentUser) async {
    if (_formKey.currentState!.validate()) {
      if (leaseEnd != null && tenant != null && unit != null) {
        final LazyLoader lazyLoader = LazyLoader(context: context);
        lazyLoader.showLoader();
        final db = DbTenantService();
        final unitDB = DbUnitsService();
        //1: create instance of the current tenant
        Tenant currentTenant = tenant!.copyWith(
          userId: currentUser!.uid,
          endOfLease: leaseEnd,
          isActive: false,
          lastUpdateDate: DateTime.now(),
        );
        try {
          //2: update the tenant information in the database
          Tenant? updatedTenant = await db.updateTenant(currentTenant);
          if (updatedTenant != null) {
            //3: add the tenant in a log of the unit's previous tenants
            List<String> previousTenants = [
              ...unit!.previousTenantsLog,
              tenant!.tenantId!,
            ];
            //4 : create instance of the updated unit
            Unit updatedUnit = unit!.copyWith(
              currentTenant: null,
              isOccupied: false,
              lastUpdateDate: DateTime.now(),
              previousTenantsLog: previousTenants,
            );
            //5: update the unit in the db
            final savedUnit = await unitDB.updateUnit(updatedUnit);

            //6: update local providers
            await ref
                .read(userInformationProvider.notifier)
                .updateUnit(savedUnit);
            await ref
                .read(userInformationProvider.notifier)
                .updateTenant(updatedTenant);

            //  7: close the workspace
            ref.read(workspaceProvider.notifier).closeWorkspace();
          }
        } catch (e, stackTrace) {
          log('Error ending the lease: $e', stackTrace: stackTrace);

          displaySnackBar(context, 'Error: $e', AppColorsConstant.redColor);
        } finally {
          lazyLoader.hideLoader();
          ref.read(workspaceProvider.notifier).closeWorkspace();
          // popPage();
        }
      }
    }
  }
}
