import 'package:anyamar/commons/exports.dart';

class NextOfKinInformationColumn extends ConsumerWidget {
  final Person? person;
  const NextOfKinInformationColumn({super.key, this.person});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardCardWidget(
      cardTitle: 'Emergency Contact Details',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.info, text: 'Name '),
              Text(
                person?.personName ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.phone, text: 'Phone'),
              Text(
                person?.personPhone ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.envelope, text: 'Email'),
              Text(
                person?.personEmail ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.creditcard,
                text: 'National ID / Passport number',
              ),
              Text(
                person?.personNationalId ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.question_circle,
                text: 'Relationship with Tenant',
              ),
              Text(
                person?.relationship ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
