import 'package:anyamar/commons/exports.dart';

class SingleUnitPage extends StatefulWidget {
  final Unit unit;

  const SingleUnitPage({super.key, required this.unit});

  @override
  State<SingleUnitPage> createState() => _SingleUnitPageState();
}

class _SingleUnitPageState extends State<SingleUnitPage> {
  bool isUpdateMode = false;
  Color? fontColor;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsiveness.isDesktop(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --------------------------------------------------
            // TOP BAR
            // --------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: BackButton(onPressed: () => Navigator.pop(context)),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 20.0),
                  child: Row(
                    children: [
                      CardButtonWidget(
                        buttonTitle: 'View tenant history',
                       onPressedCallBack: () => Navigator.of(context).push(
                          (MaterialPageRoute(
                            builder: (_) => UnitTenantHistory(unit: widget.unit),
                          )),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      CardButtonWidget(
                        buttonTitle: 'View rent history',

                        onPressedCallBack: () => Navigator.of(context).push(
                          (MaterialPageRoute(
                            builder: (_) => UnitRentHistory(unit: widget.unit),
                          )),
                        ),
                      ),

                      SizedBox(width: 10.0),
                      CardButtonWidget(
                        buttonTitle: isUpdateMode
                            ? 'Go back'
                            : 'Click here to update this unit',
                        fontColor: fontColor,
                        onPressedCallBack: () {
                          setState(() {
                            isUpdateMode = !isUpdateMode;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // --------------------------------------------------
            // PAGE CONTENT
            // --------------------------------------------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop ? 500 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unit ${widget.unit.unitName} Information',
                          style: CustomTextStyles.cardDescriptionStyle.copyWith(
                            color: AppColorsConstant.darkBlueColor,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // --------------------------------------------------
                        // CONTENT
                        // --------------------------------------------------
                        if (isUpdateMode)
                          AddOrUpdateUnitForm(
                            unit: widget.unit,
                            isInUnitPage: true,
                          )
                        else
                          UnitInformationColumn(unit: widget.unit),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnitInformationColumn extends ConsumerWidget {
  final Unit unit;
  const UnitInformationColumn({super.key, required this.unit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalAmountPayableMonthly =
        unit.unitRent!.rentAmount +
        (unit.unitRent?.utilities ?? []).fold<double>(
          0,
          (sum, utility) => sum + utility.amountPayable,
        );
    //Get tenant in unit
    Tenant? unitTenant = ref
        .watch(userInformationProvider.select((state) => state.tenants))
        .where((t) => t.tenantId == unit.tenantId)
        .singleOrNull;
    Property? unitProperty = ref
        .watch(userInformationProvider.select((state) => state.properties))
        .where((p) => p.propertyId == unit.propertyId)
        .singleOrNull;

    return Column(
      children: [
        //? Unit name or Id
        Row(
          children: [
            Expanded(
              child: InfoTile(
                tileIcon: CupertinoIcons.app_badge,
                tileTitle: 'Unit Name / ID: ',
                tileDescription: unit.unitName,
              ),
            ),
          ],
        ),

        //? Current Tenant Information
        unitTenant != null
            ? Row(
                children: [
                  Expanded(
                    child: InfoTile(
                      tileIcon: CupertinoIcons.person,
                      tileTitle: 'Tenant ',
                      tileDescription: unitTenant.tenantName,
                      onTapCallBack: () =>
                          //redirect to single tenant information
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  SingleTenantPage(tenant: unitTenant),
                            ),
                          ),
                    ),
                  ),
                ],
              )
            : Row(
                // If there is no tenant display vacancy badge
                children: [
                  Expanded(
                    child: InfoTile(
                      tileIcon: CupertinoIcons.person,
                      tileTitle: 'Status',
                      tileDescription: '',
                      trailingWidget: SizedBox(
                        width: 70,
                        height: 30,
                        child: InformationBadge(
                          text: 'Vacant',
                          textColor: getOccupancyStatus(
                            unit.isOccupied,
                          ).textColor,
                          badgeColor: getOccupancyStatus(
                            unit.isOccupied,
                          ).badgeColor,
                        ),
                      ),
                      //Add tenant for this unit
                      onTapCallBack: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AddTenant(
                            currentUnit: unit,
                            currentProperty: unitProperty,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        //Rent Deposit
        Row(
          children: [
            Expanded(
              child: InfoTile(
                tileIcon: CupertinoIcons.money_dollar,
                tileTitle: 'Rent Deposit ',
                tileDescription:
                    ' ${unit.unitRent?.rentCurrency ?? 'Ksh'}  ${formatMoney(unit.unitRent?.rentDeposit ?? 0.0)}',
                onTapCallBack: () {},
              ),
            ),
          ],
        ),
        //Rent
        Row(
          children: [
            Expanded(
              child: InfoTile(
                tileIcon: CupertinoIcons.money_dollar,
                tileTitle:
                    'Rent / ${unit.unitRent?.paymentFrequency ?? 'Month'} ',
                tileDescription:
                    ' ${unit.unitRent?.rentCurrency}  ${formatMoney(unit.unitRent?.rentAmount ?? 0.0)}',
                onTapCallBack: () {},
              ),
            ),
          ],
        ),

        SizedBox(height: 10.0),
        // Utilities
        if (unit.unitRent?.utilities != null &&
            unit.unitRent!.utilities!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    'Utilities',
                    style: CustomTextStyles.cardDescriptionStyle.copyWith(
                      color: AppColorsConstant.kGreen6,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                ...unit.unitRent!.utilities!.map((utility) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InfoTile(
                            tileIcon: getUtilityIcon(utility.utilityName),
                            tileTitle: utility.utilityName.label,
                            tileDescription:
                                'Ksh ${formatMoney(utility.amountPayable)}',
                            onTapCallBack: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        //Total amount payable
        Row(
          children: [
            Expanded(
              child: InfoTile(
                tileIcon: CupertinoIcons.question,
                tileTitle: 'Monthly Total:',
                tileDescription:
                    'ksh ${formatMoney(totalAmountPayableMonthly)}',
                onTapCallBack: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
