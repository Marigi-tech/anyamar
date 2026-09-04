import 'package:anyamar/commons/exports.dart';

class RentalMonthForm extends ConsumerStatefulWidget {
  final RentalMonth currentMonth;
  final RentHistory rentHistory;
  final Tenant tenant;
  final Unit unit;
  const RentalMonthForm({
    super.key,
    required this.currentMonth,
    required this.rentHistory,
    required this.tenant,
    required this.unit,
  });

  @override
  ConsumerState<RentalMonthForm> createState() => _RentalMonthFormState();
}

class _RentalMonthFormState extends ConsumerState<RentalMonthForm> {
  TextEditingController amountController = TextEditingController();
  MonthModel? selectedMonth;
  TextEditingController yearController = TextEditingController();
  List<SingleRentEntry> rentalEntries = [];

  double totalAmountPayable = 0;
  double totalAmountPaid = 0;
  double balance = 0;
  double excess = 0;

  // ============================================================
  // INIT
  // ============================================================
  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final parts = widget.currentMonth.rentalMonth.split('/');

    final String month = parts[0];
    final String year = parts[1];

    // ==========================================================
    // UPDATE MODE
    // ==========================================================
    amountController.text = totalAmountPayable.toString();
    selectedMonth = appMonths.firstWhere((item) => item.monthName == month);
    yearController.text = year.toString();
  }
  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    amountController.dispose();
    yearController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rentHistoryAsync = ref.watch(rentProvider(widget.tenant.tenantId!));

    return rentHistoryAsync.when(
      loading: () => const CircularProgressIndicator(),

      error: (error, stackTrace) {
        return Text('Error: $error');
      },

      data: (history) {
        if (history == null) {
          return const Text('No rent history');
        }

        final currentMonth = history.rentalMonths
            .where(
              (month) => month.rentalMonth == widget.currentMonth.rentalMonth,
            )
            .firstOrNull;
        rentalEntries = currentMonth?.rentEntries ?? [];

        totalAmountPayable = widget.currentMonth.unitRent != null
            ? widget.currentMonth.unitRent!.rentAmount +
                  (widget.currentMonth.unitRent?.utilities ?? []).fold<double>(
                    0,
                    (sum, utility) => sum + utility.amountPayable,
                  )
            : 0.0;

        totalAmountPaid = rentalEntries.fold<double>(
          0.0,
          (sum, entry) => sum + entry.amountPaid,
        );
        balance = (totalAmountPayable - totalAmountPaid).clamp(
          0.0,
          double.infinity,
        );

        excess = (totalAmountPaid - totalAmountPayable).clamp(
          0.0,
          double.infinity,
        );

        return DashboardForm(
          form: FormPages(
            pageTitle:
                ' Update ${widget.currentMonth.rentalMonth} rent records ',

            form: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 06.0),
                // --------------------------------------------------
                // AMOUNT PAYABLE
                // --------------------------------------------------
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        tileIcon: Icons.wallet,
                        tileTitle: 'Amount payable',
                        tileDescription:
                            'Ksh ${formatMoneyValue(totalAmountPayable.toString())}',
                        onTapCallBack: () {},
                      ),
                    ),
                  ],
                ),

                // --------------------------------------------------
                // AMOUNT PAID
                // --------------------------------------------------
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        tileIcon: Icons.wallet,
                        tileTitle: 'Amount paid',
                        tileDescription:
                            'Ksh ${formatMoneyValue(totalAmountPaid.toString())}',
                        onTapCallBack: () {},
                      ),
                    ),
                  ],
                ),

                // --------------------------------------------------
                // BALANCE / EXCESS
                // --------------------------------------------------
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        tileIcon: Icons.wallet,
                        tileTitle: excess > 0 ? 'Excess' : 'Balance',
                        tileDescription:
                            'Ksh ${excess > 0 ? formatMoneyValue(excess.toString()) : formatMoneyValue(balance.toString())}',
                        titleColor: excess > 0
                            ? AppColorsConstant.greenColor
                            : AppColorsConstant.redColor,

                        onTapCallBack: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // --------------------------------------------------
                // PAYMENT ENTRIES
                // --------------------------------------------------
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Payments',
                    style: CustomTextStyles.cardDescriptionStyle.copyWith(
                      color: AppColorsConstant.darkBlueColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (rentalEntries.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        'No payments have been recorded for this month.',
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rentalEntries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final entry = rentalEntries[index];

                      return _buildPaymentEntry(entry, index);
                    },
                  ),
                const SizedBox(height: 10),
                if (totalAmountPaid < totalAmountPayable)
                  ColorButtonWidget(
                    onPressedCallBack: () => Navigator.of(context).push(
                      (MaterialPageRoute(
                        builder: (_) => AddRentalRecord(
                          unit: widget.unit,
                          tenant: widget.tenant,
                          rentalMonth: widget.currentMonth,
                        ),
                      )),
                    ),

                    buttonTitle: 'Add Rent Entry',
                    buttonColor: AppColorsConstant.greenColor,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentEntry(SingleRentEntry entry, int index) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment number
            Text(
              'Payment ${index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            ),
            // Transaction code
            const SizedBox(height: 8),
            //TODO: FIX TRANSACTION CODE (KIND OF LIKE AN INVOICE  NUMBER (UNIQUE))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Transaction code '),
                Text(
                  '${entry.transactionCode}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Amount paid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Amount paid'),
                Text(
                  'Ksh ${formatMoney(entry.amountPaid)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 5),

            // Payment method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Payment method'),
                SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: InformationBadge(
                          text: entry.paymentMethod.label,
                          textColor: getPaymentMethodStatus(
                            entry.paymentMethod,
                          ).textColor,
                          badgeColor: getPaymentMethodStatus(
                            entry.paymentMethod,
                          ).badgeColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
            // Payment date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Date paid'),
                Text(formatPrettyDate(entry.paymentDate)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
