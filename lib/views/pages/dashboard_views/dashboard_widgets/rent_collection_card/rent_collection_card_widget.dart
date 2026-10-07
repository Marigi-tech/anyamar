import 'package:anyamar/commons/exports.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RentCollectionCard extends ConsumerStatefulWidget {
  const RentCollectionCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RentCollectionCardState();
}

class _RentCollectionCardState extends ConsumerState<RentCollectionCard> {
  List<RentalRecord> thisMonthRecords = [];
  List<RentalMonth> rentalMonths = [];
  String? selectedRentalMonth;
  //get current Rental month
  String currentRentalMonth = formatMonthAndYearName(DateTime.now());

  @override
  void initState() {
    super.initState();
    selectedRentalMonth = currentRentalMonth;
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInformationProvider);
    //get all rental records
    List<RentalRecord> rentalRecords = userInfo.appData?.rentRecords ?? [];
    //active tenants
    List<Tenant> activeTenants = userInfo.appData?.activeTenants.toList() ?? [];
    // expected rental income for this month
    final double expectedRentalIncome = activeTenants.fold<double>(0.0, (
      total,
      tenant,
    ) {
      final rent = tenant.unitRent?.rentAmount ?? 0.0;

      final utilities = (tenant.unitRent?.utilities ?? []).fold<double>(
        0.0,
        (sum, utility) => sum + utility.amountPayable,
      );

      return total + rent + utilities;
    });
    //all recorded rental months
    rentalMonths = rentalRecords
        .map((record) => record.rentalMonth)
        .where((rentalMonth) => rentalMonth.rentalMonth != currentRentalMonth)
        .toList();

    // this month's rental records
    thisMonthRecords = rentalRecords
        .where(
          (record) => record.rentalMonth.rentalMonth == selectedRentalMonth,
        )
        .toList();

    // current collected rental income for this month
    double? collectedRentalIncome = thisMonthRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.rentEntry.amountPaid,
    );
    //collected percentage
    double collectedPercentage = collectedRentalIncome / expectedRentalIncome;
    //Outstanding balance

    double outStandingBalance = expectedRentalIncome - collectedRentalIncome;

    final themeIsDark = ref.watch(themeIsDarkProvider);

    return DashboardCardWidget(
      cardTitle: 'Rent Collection - ',

      buttonWidget1: Container(
        padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 3),
        decoration: BoxDecoration(
          border: Border.all(
            color: themeIsDark == true
                ? AppColors.darkCard
                : const Color(0xFFDCE2EB),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                selectedRentalMonth != currentRentalMonth
                    ? '$selectedRentalMonth '
                    : 'This Month ',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: themeIsDark == true
                      ? AppColors.darkText
                      : const Color(0xFF25344B),
                ),
              ),
              PopupMenuButton<String>(
                tooltip: '',
                icon: const Icon(Icons.keyboard_arrow_down, size: 17),

                onSelected: (value) {
                  LazyLoader lazyLoader = LazyLoader(context: context);
                  lazyLoader.showLoader();
                  setState(() {
                    selectedRentalMonth = value;
                  });
                  lazyLoader.hideLoader();
                },

                itemBuilder: (context) {
                  return rentalMonths
                      .map(
                        (month) => PopupMenuItem<String>(
                          value: month.rentalMonth,
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.calendar, size: 18),
                              SizedBox(width: 10),
                              Text(month.rentalMonth),
                            ],
                          ),
                        ),
                      )
                      .toList();
                },
              ),
            ],
          ),
        ),
      ),

      child: Column(
        children: [
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 175,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 55,
                        lineWidth: 11,
                        percent: collectedPercentage,
                        startAngle: 0,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: const Color(0xFFE6E9ED),
                        progressColor: const Color(0xFF24B358),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Text(
                            '${(collectedPercentage * 100).truncateToDouble()} %',
                            style: GoogleFonts.inter(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF168B47),
                            ),
                          ),
                          Text(
                            'Collected',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF25344B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    _CollectionRow(
                      color: const Color(0xFF29B35A),
                      title: 'Collected',
                      amount: formatMoneyWithCurrency(
                        collectedRentalIncome,
                        'Ksh',
                      ),
                    ),
                    SizedBox(height: 4),
                    _CollectionRow(
                      color: const Color(0xFF2869DB),
                      title: 'Outstanding',
                      amount: formatMoneyWithCurrency(
                        outStandingBalance,
                        'Ksh',
                      ),
                    ),
                    SizedBox(height: 4),
                    _CollectionRow(
                      color: const Color(0xFFADB3BC),
                      title: 'Expected',
                      amount: formatMoneyWithCurrency(
                        expectedRentalIncome,
                        'Ksh',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CollectionRow extends StatelessWidget {
  final Color color;
  final String title;
  final String amount;

  const _CollectionRow({
    required this.color,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE9EDF2))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF39465A),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            amount,
            style: GoogleFonts.inter(
              fontSize: 12,

              fontWeight: FontWeight.w600,
              color: const Color(0xFF17243B),
            ),
          ),
        ],
      ),
    );
  }
}
