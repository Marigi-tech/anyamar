import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/date_format/date_format_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/info_tile.dart';
import 'package:anyamar/views/reusable_widgets/information_badges/information_badge_widget.dart';

class RentEntryModal extends StatelessWidget {
  final SingleRentEntry rentEntry;

  const RentEntryModal({super.key, required this.rentEntry});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 6,
      constraints: BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Rent entry for ${rentEntry.rentalMonth}',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                CloseButton(),
              ],
            ),
            SizedBox(height: 10.0),
            //? Date paid
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.calendar,
                    tileTitle: 'Date paid',
                    tileDescription: formatPrettyDate(rentEntry.paymentDate),
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),

            //? Amount payable
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.money_dollar,
                    tileTitle: 'Amount payable',
                    tileDescription: 'Ksh ${rentEntry.amountPayable}',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
            //? Amount paid
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.money_dollar,
                    tileTitle: 'Amount paid',
                    tileDescription: 'Ksh ${rentEntry.amountPaid}',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
            //? Balance
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.money_dollar,
                    tileTitle: 'Balance',
                    tileDescription:
                        'Ksh ${rentEntry.amountPayable - rentEntry.amountPaid}',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
            //? Payment Method
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.creditcard,
                    tileTitle: 'Payment method',
                    tileDescription: '${rentEntry.paymentMethod}',
                    tileDescriptionWidget: SizedBox(
                      width: 70,
                      height: 30,
                      child: InformationBadge(
                        text: rentEntry.paymentMethod.label,
                        textColor: getPaymentMethodStatus(
                          rentEntry.paymentMethod.label,
                        ).textColor,
                        badgeColor: getPaymentMethodStatus(
                          rentEntry.paymentMethod.label,
                        ).badgeColor,
                      ),
                    ),
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Visibility(
              visible: rentEntry.amountPayable - rentEntry.amountPaid == 0
                  ? false
                  : true,
              child: Column(
                children: [
                  Text('Renter\'s notes'),
                  Text('Break down how we arrived at balance'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
