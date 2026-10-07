import 'package:anyamar/commons/exports.dart';

class RelatedInfoColumn extends ConsumerWidget {
  final String? personName;
  final String? propertyName;
  final String? unitName;
  final bool isRent;

  const RelatedInfoColumn({
    super.key,
    this.personName,
    this.propertyName,
    this.unitName,
    required this.isRent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardCardWidget(
      cardTitle: 'Related Information',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Person Name
          RelatedInfoRow(
            circleWidget: Text(
              getInitials(personName ?? ''),
              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                color:
                    avatarBackgroundColors[1 % avatarBackgroundColors.length],
                fontStyle: FontStyle.normal,
              ),
            ),
            rowSuperText: isRent ? 'Tenant ' : 'Paid By',
            rowTitle: personName ?? '',
            backgroundColor:
                avatarBackgroundColors[1 % avatarBackgroundColors.length],
          ),

          if (isRent == true) CardItemSeparator(),
          //Unit
          if (isRent == true)
            RelatedInfoRow(
              circleWidget: Icon(
                Icons.house,
                size: 15,
                color:
                    avatarBackgroundColors[2 % avatarBackgroundColors.length],
              ),
              rowSuperText: 'Unit',
              rowTitle: unitName,
              backgroundColor:
                  avatarBackgroundColors[2 % avatarBackgroundColors.length],
            ),
          CardItemSeparator(),
          //Property
          RelatedInfoRow(
            circleWidget: Icon(
              Icons.apartment,
              size: 15,
              color: avatarBackgroundColors[3 % avatarBackgroundColors.length],
            ),
            rowSuperText: 'Property',
            rowTitle: propertyName,
            backgroundColor:
                avatarBackgroundColors[3 % avatarBackgroundColors.length],
          ),

          CardItemSeparator(),
        ],
      ),
    );
  }

  // Widget build(BuildContext context, WidgetRef ref) {
  //   return Container();
  // }
}

class RelatedInfoRow extends StatelessWidget {
  final Widget circleWidget;
  final String? rowTitle;
  final String? rowSuperText;
  final String? rowSubTitle;
  final Color backgroundColor;
  const RelatedInfoRow({
    super.key,
    required this.circleWidget,
    this.rowTitle,
    this.rowSubTitle,
    this.rowSuperText,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: backgroundColor.withValues(alpha: 0.2),

          // backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.5),
          child: Center(child: circleWidget),
        ),

        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              rowSuperText ?? '',
              style: CustomTextStyles.cardExtraDescriptionStyle.copyWith(
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 5),
            Text(
              rowTitle ?? '',
              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                fontStyle: FontStyle.normal,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Text(
              rowSubTitle ?? '',
              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
