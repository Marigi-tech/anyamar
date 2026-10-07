import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/welcome_text.dart';


class TenantDetailsCard extends ConsumerWidget {
  final Tenant? tenant;
  const TenantDetailsCard({super.key, this.tenant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.read(themeIsDarkProvider);
    return DashboardCardWidget(
      cardTitle: 'Tenant details',
      cardHeight: 520,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Tenant Info
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                Row(
                  children: [
                    //Tenant Initials
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromARGB(255, 183, 202, 247),
                        child: tenant?.tenantName != null
                            ? TenantNameText(
                                isInitials: true,
                                tenantName: tenant!.tenantName,
                              )
                            : Image.asset(
                                'assets/images/user.png',
                                width: 20,
                                height: 21,

                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    if (tenant != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tenant?.tenantName ?? '',
                            style: CustomTextStyles.cardDescriptionStyle
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: themeIsDark == true
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                          ),
                          SizedBox(height: 7.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RowTitleWidget(
                                iconColor: AppColors.primaryBlue,
                                icon: Icons.phone,
                                text: tenant?.tenantPhoneNumber ?? '',
                              ),
                            ],
                          ),
                          SizedBox(height: 06.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RowTitleWidget(
                                iconColor: AppColors.primaryBlue,
                                icon: CupertinoIcons.envelope,
                                text: tenant?.tenantEmail ?? '',
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          //Move in date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Move in date'),
              Text(
                tenant?.startOfLease != null
                    ? formatPrettyDate(tenant!.startOfLease)
                    : '',
              ),
            ],
          ),
          CardItemSeparator(),
          //Next of kin
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Emergency contact'),
              Text(tenant?.nextOfKin?.personName ?? ''),
            ],
          ),
          CardItemSeparator(),
          //Next of kin
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Emergency contact number'),
              Text(tenant?.nextOfKin?.personPhone ?? ''),
            ],
          ),
          CardItemSeparator(),
          //Next of kin email
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Emergency contact email'),
              Text(tenant?.nextOfKin?.personEmail ?? ''),
            ],
          ),
          CardItemSeparator(),
          SizedBox(height: 10.0),
          //Move out date
          if (tenant?.endOfLease != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(text: 'Move out date'),
                Text(formatPrettyDate(tenant!.endOfLease!)),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButtonWidget(
                buttonIcon: Icon(Icons.person),
                buttonTitle: 'View tenant\'s details',
                onButtonPressedCallBack: () {},
              ),
            ],
          ),
          SizedBox(height: 5),
          //End lease button
          if (tenant != null && tenant?.endOfLease == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButtonWidget(
                  buttonIcon: Icon(Icons.close),
                  buttonTitle: 'End ${tenant?.tenantName}\'s lease',
                  isClear: true,
                  onButtonPressedCallBack: () {},
                ),
              ],
            ),
          if (tenant == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButtonWidget(
                  buttonIcon: Icon(Icons.add),
                  buttonTitle: 'Add a tenant',
                  isClear: true,
                  onButtonPressedCallBack: () {},
                ),
              ],
            ),
        ],
      ),
    );
  }
}
