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
  String? selectedRentalMonthYear;
  double? excessCollection;
  double? outstandingBalance = 0;
  //get current Rental month
  String currentRentalMonth = formatMonthAndYearName(DateTime.now());

  @override
  void initState() {
    super.initState();

    selectedRentalMonth = currentRentalMonth;

    final parts = currentRentalMonth.split('/');
    if (parts.length == 2) {
      selectedRentalMonthYear = parts[1].trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userInformationProvider);

    //get all rental records
    List<RentalRecord> rentalRecords = userInfo.rentalRecords;
    //active tenants
    List<Tenant> activeTenants = userInfo.activeTenants.toList();
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
    //Rental months that can be displayed in the popup
    rentalMonths = rentalRecords.map((record) => record.rentalMonth).where((
      rentalMonth,
    ) {
      final parts = rentalMonth.rentalMonth.split('/');
      if (parts.length != 2) return false;
      final month = parts[0].trim();
      final year = parts[1].trim();
      final selectedMonth = selectedRentalMonth?.trim();
      final selectedYear = selectedRentalMonthYear?.trim();
      return '$month/$year' != selectedMonth && year == selectedYear;
    }).toList();
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
    final double collectedPercentage = expectedRentalIncome > 0
        ? collectedRentalIncome / expectedRentalIncome
        : 0.0;
    // indicator percentage
    final double indicatorPercent = collectedPercentage.clamp(0.0, 1.0);
    // excess Collection
    excessCollection = collectedRentalIncome > expectedRentalIncome
        ? collectedRentalIncome - expectedRentalIncome
        : null;
    //Outstanding balance
    outstandingBalance = expectedRentalIncome > collectedRentalIncome
        ? expectedRentalIncome - collectedRentalIncome
        : null;
    //Theme
    final themeIsDark = ref.watch(themeIsDarkProvider);

    return DashboardCardWidget(
      cardTitle: 'Rent Collection (${formatYearName(DateTime.now())}) - ',

      buttonWidget1: Container(
        padding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedRentalMonth != currentRentalMonth
                    ? '$selectedRentalMonth '
                    : ' This Month ',
                style: CustomTextStyles.cardDescriptionStyle.copyWith(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  color: themeIsDark == true
                      ? AppColors.darkText
                      : const Color(0xFF25344B),
                ),
              ),
              PopupMenuButton<String>(
                tooltip: '',
                icon: const Icon(Icons.keyboard_arrow_down, size: 14),
                onSelected: (value) {
                  final parts = value.split('/');
                  if (parts.length != 2) {
                    debugPrint('Invalid rental month format: $value');
                    return;
                  }
                  setState(() {
                    selectedRentalMonth = value;
                    selectedRentalMonthYear = parts[1];
                  });
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
                        lineWidth: 7,
                        percent: indicatorPercent,
                        startAngle: 0,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: const Color(0xFFE6E9ED),
                        progressColor: collectedPercentage > 1.0
                            ? AppColors
                                  .orange // Over-collected
                            : const Color(0xFF24B358), // Normal collection
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Text(
                            '${(collectedPercentage * 100).toStringAsFixed(0)} %',
                            style: AppTextStylesConstant.cardDescriptionStyle
                                .copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: collectedPercentage > 1.0
                                      ? AppColors.orange
                                      : const Color(0xFF168B47),
                                ),
                          ),
                          SizedBox(height: 05),

                          Text(
                            'Collected',
                            style: AppTextStylesConstant.cardDescriptionStyle
                                .copyWith(
                                  fontSize: 11,
                                  color: themeIsDark == true
                                      ? AppColors.darkText
                                      : const Color(0xFF25344B),
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
                    if (outstandingBalance != null)
                      _CollectionRow(
                        color: const Color(0xFF2869DB),
                        title: 'Outstanding',
                        amount: formatMoneyWithCurrency(
                          outstandingBalance ?? 0.0,
                          'Ksh',
                        ),
                      ),
                    if (excessCollection != null)
                      _CollectionRow(
                        color: AppColors.orange,
                        title: 'Excess collected',
                        amount: formatMoneyWithCurrency(
                          excessCollection ?? 0.0,
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

class _CollectionRow extends ConsumerWidget {
  final Color color;
  final String title;
  final String amount;

  const _CollectionRow({
    required this.color,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
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
                    fontStyle: FontStyle.normal,
                    color: themeIsDark == true
                        ? AppColors.darkText
                        : const Color(0xFF39465A),
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
              color: themeIsDark == true
                  ? AppColors.darkText
                  : const Color(0xFF17243B),
            ),
          ),
        ],
      ),
    );
  }
}
