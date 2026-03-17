import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/data/models/date_format_model.dart';
import 'package:test_app/data/models/single_rental_entry_model.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/info_tile.dart';
import 'package:test_app/views/widgets/information_badges/information_badge_widget.dart';

class RentEntryModal extends StatelessWidget {
  final SingleRentEntry rentEntry;
  const RentEntryModal({super.key, required this.rentEntry});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 06),
        child: Column(
          children: [
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
                          rentEntry.paymentMethod,
                        ).textColor,
                        badgeColor: getPaymentMethodStatus(
                          rentEntry.paymentMethod,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rent entry for ${rentEntry.rentalMonth}',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          CloseButton(),
        ],
      ),
    );
  }
}
