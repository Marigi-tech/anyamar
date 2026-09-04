import 'package:anyamar/commons/exports.dart';

class FinancialRecordModal extends StatelessWidget {
  final FinancialRecord financialRecord;

  const FinancialRecordModal({super.key, required this.financialRecord});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 6,
      constraints: BoxConstraints(maxWidth: 550),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Financial Record : ${financialRecord.recordId}',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                CloseButton(),
              ],
            ),
            SizedBox(height: 10.0),
            //Date
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.calendar,
                    tileTitle: 'Payment date',
                    tileDescription: formatPrettyDate(financialRecord.datePaid),
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),

            //Amount paid
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.money_dollar,
                    tileTitle: 'Amount',
                    tileDescription:
                        'Ksh ${formatMoney(financialRecord.amountPaid)}',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
            //Record Type
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: Icons.menu_outlined,
                    tileTitle: 'Type',
                    tileDescription: financialRecord.recordType.label,
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
            //Type of record
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.creditcard,
                    tileTitle: 'Record type',
                    tileDescription: financialRecord.recordNature.label,
                    trailingWidget: SizedBox(
                      width: 70,
                      height: 30,
                      child: InformationBadge(
                        text: financialRecord.recordNature.label,
                        textColor: getPaymentType(
                          financialRecord.recordNature,
                        ).textColor,
                        badgeColor: getPaymentType(
                          financialRecord.recordNature,
                        ).badgeColor,
                      ),
                    ),
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),

            //Payment method
            if (financialRecord.paymentMethod != null)
              Row(
                children: [
                  Expanded(
                    child: InfoTile(
                      tileIcon: CupertinoIcons.creditcard,
                      tileTitle: 'Payment method',
                      tileDescription: '${financialRecord.paymentMethod}',
                      trailingWidget: SizedBox(
                        width: 70,
                        height: 30,
                        child: InformationBadge(
                          text: financialRecord.paymentMethod?.label ?? '',
                          textColor: getPaymentMethodStatus(
                            financialRecord.paymentMethod,
                          ).textColor,
                          badgeColor: getPaymentMethodStatus(
                            financialRecord.paymentMethod,
                          ).badgeColor,
                        ),
                      ),
                      onTapCallBack: () {},
                    ),
                  ),
                ],
              ),
            //Paid to : Payment From
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: Icons.menu_outlined,
                    tileTitle:
                        financialRecord.recordNature ==
                            FinancialRecordNature.expense
                        ? 'Paid to :'
                        : 'Payment from : ',
                    tileDescription: financialRecord.paymentBy.personName,
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
