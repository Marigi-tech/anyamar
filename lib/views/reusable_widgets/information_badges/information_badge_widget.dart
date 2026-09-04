import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/enums/financial_record_nature.dart';
import 'package:anyamar/data/models/enums/payment_methods_enum.dart';
import 'package:anyamar/data/models/enums/payment_status_enum.dart';
import 'package:anyamar/data/models/enums/property_utilities_enum.dart';
import 'package:flutter/cupertino.dart';

class InformationBadge extends StatelessWidget {
  final String text;
  final Color badgeColor;
  final Color textColor;
  const InformationBadge({
    super.key,
    required this.text,
    required this.badgeColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          border: Border.all(color: textColor),
          borderRadius: BorderRadius.circular(20),
          color: badgeColor,
        ),
        child: FittedBox(
          child: Text(
            text,
            style: CustomTextStyles.cardDescriptionStyle.copyWith(
              color: AppColorsConstant.whiteColor,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
    // return Badge(
    //   backgroundColor: badgeColor,
    //   textColor: textColor,
    //   smallSize: 15,
    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //   label: Text(text),
    //   textStyle: CustomTextStyles.cardDescriptionStyle,

    // );
  }
}

//Occupancy status method
({Color textColor, Color badgeColor}) getOccupancyStatus(bool? isOccupied) {
  Color backgroundColor;
  Color textColor;

  if (isOccupied == true) {
    backgroundColor = AppColorsConstant.lightGreenColor;
    textColor = AppColorsConstant.darkGreenColor;
  } else {
    textColor = AppColorsConstant.darkRedColor;
    backgroundColor = AppColorsConstant.redColor;
  }

  return (textColor: textColor, badgeColor: backgroundColor);
}

//Payment type
({Color textColor, Color badgeColor}) getPaymentType(
  FinancialRecordNature paymentType,
) {
  Color? bColor;
  Color? tColor;

  if (paymentType == FinancialRecordNature.revenue) {
    bColor = AppColorsConstant.lightGreenColor;
    tColor = AppColorsConstant.darkGreenColor;
  }
  if (paymentType == FinancialRecordNature.expense) {
    bColor = AppColorsConstant.redColor;
    tColor = AppColorsConstant.darkRedColor;
  }

  return (
    textColor: tColor ?? AppColorsConstant.kWhite1,
    badgeColor: bColor ?? AppColorsConstant.bgColor,
  );
}

//payment method
({Color textColor, Color badgeColor}) getPaymentMethodStatus(
  PaymentMethods? paymentMethod,
) {
  Color backgroundColor;
  Color textColor;

  if (paymentMethod == PaymentMethods.mpesa) {
    backgroundColor = AppColorsConstant.lightGreenColor;
    textColor = AppColorsConstant.whiteColor;
  } else if (paymentMethod == PaymentMethods.cash) {
    backgroundColor = AppColorsConstant.lightBlueColor;
    textColor = AppColorsConstant.whiteColor;
  } else {
    textColor = AppColorsConstant.whiteColor;
    backgroundColor = AppColorsConstant.kOrange1;
  }

  return (textColor: textColor, badgeColor: backgroundColor);
}

// Payment Status
({Color textColor, Color badgeColor}) getPaymentStatus(
  PaymentStatus paymentStatus,
) {
  Color? bColor;
  Color? tColor;

  if (paymentStatus == PaymentStatus.complete) {
    bColor = AppColorsConstant.lightGreenColor;
    tColor = AppColorsConstant.darkGreenColor;
  }
  if (paymentStatus == PaymentStatus.notPaid) {
    bColor = const Color.fromARGB(255, 240, 20, 5);
    tColor = AppColorsConstant.darkRedColor;
  }
  if (paymentStatus == PaymentStatus.partial) {
    bColor = AppColorsConstant.kOrange1;
    tColor = AppColorsConstant.kOrange2;
  }
  if (paymentStatus == PaymentStatus.excess) {
    bColor = AppColorsConstant.kBlue1;
    tColor = AppColorsConstant.whiteColor;
  }

  return (
    textColor: tColor ?? AppColorsConstant.kWhite1,
    badgeColor: bColor ?? AppColorsConstant.bgColor,
  );
}

//Utilities
getUtilityIcon(PropertyUtility utility) {
  IconData? selectedIcon;
  if (utility == PropertyUtility.electricity) {
    selectedIcon = Icons.electrical_services;
  }
  if (utility == PropertyUtility.garbage) {
    selectedIcon = CupertinoIcons.trash;
  }
  if (utility == PropertyUtility.security) {
    selectedIcon = Icons.security;
  }
  if (utility == PropertyUtility.water) {
    selectedIcon = Icons.water;
  }

  return selectedIcon ?? Icons.upcoming;
}
