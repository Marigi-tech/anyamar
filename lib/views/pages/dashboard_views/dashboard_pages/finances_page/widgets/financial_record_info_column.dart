import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_method_badge.dart';

class FinancialRecordInformationColumn extends ConsumerWidget {
  final FinancialRecord? financialRecord;
  final SingleRentEntry? rentEntry;
  const FinancialRecordInformationColumn({
    super.key,
    this.financialRecord,
    this.rentEntry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? recordId = financialRecord != null
        ? financialRecord?.recordId
        : rentEntry?.rentEntryId;
    DateTime? datePaid = financialRecord != null
        ? financialRecord?.datePaid
        : rentEntry?.paymentDate;
    double? amountPaid = financialRecord != null
        ? financialRecord?.amountPaid
        : rentEntry?.amountPaid;
    FinancialRecordTypes recordType = financialRecord != null
        ? financialRecord!.recordType
        : FinancialRecordTypes.rent;
    String? paymentBy = financialRecord != null
        ? financialRecord?.paymentBy.personName
        : rentEntry?.tenantName;
    PaymentMethods? paymentMethod = financialRecord != null
        ? financialRecord?.paymentMethod
        : rentEntry?.paymentMethod;
    FinancialRecordNature? recordNature = financialRecord != null
        ? financialRecord?.recordNature
        : FinancialRecordNature.revenue;

    return DashboardCardWidget(
      cardTitle: 'Basic Information',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.info, text: 'Record Id'),
              Text(
                recordId ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.wallet, text: 'Amount paid'),
              Text(
                amountPaid != null
                    ? formatMoneyWithCurrency(amountPaid, 'Ksh')
                    : 'N/A',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Date paid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.calendar_month, text: 'Date paid'),
              Text(
                datePaid != null ? formatPrettyDate(datePaid) : 'N/A',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Record Type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.question,
                text: 'Record type',
              ),
              Text(
                recordType.label,
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),

          CardItemSeparator(),
          //Payment By
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.person, text: 'Payment By'),
              Text(
                paymentBy ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Financial Nature
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.wallet, text: 'Financial nature'),
              Text(
                recordNature?.label ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.wallet, text: 'Payment method'),
              PaymentMethodBadge(method: paymentMethod),
            ],
          ),
        ],
      ),
    );
  }
}
