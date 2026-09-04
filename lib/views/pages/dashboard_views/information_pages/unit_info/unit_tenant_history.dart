import 'package:anyamar/commons/exports.dart';

class UnitTenantHistory extends ConsumerStatefulWidget {
  final Unit unit;
  const UnitTenantHistory({super.key, required this.unit});

  @override
  ConsumerState<UnitTenantHistory> createState() => _UnitTenantHistoryState();
}

class _UnitTenantHistoryState extends ConsumerState<UnitTenantHistory> {
  List<Tenant> myTenants = [];
  List<Property> myProperties = [];

  @override
  Widget build(BuildContext context) {
    //get all tenants who have lived in this unit
    myTenants = ref
        .watch(userInformationProvider.select((state) => state.tenants))
        .where((tenant) => tenant.unitId == widget.unit.unitId)
        .toList();
    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBackButton(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CustomDataTable(
                    customDataColumns: [...buildTenantHeaderRows(false, false)],
                    customDataRows: [
                      ...myTenants.toList().asMap().entries.map((entry) {
                        int index = entry.key;
                        Tenant tenant = entry.value;
                        Property? property = myProperties
                            .where(
                              (prop) =>
                                  prop.propertyId == widget.unit.propertyId,
                            )
                            .singleOrNull;

                        return buildTenantDataRow(
                          index + 1,
                          tenant,
                          context,
                          property?.propertyName ?? '',
                          ref,
                          null,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //     },
    //   ),
    // );
  }
}
