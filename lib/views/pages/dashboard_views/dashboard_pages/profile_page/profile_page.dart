import 'dart:developer';
import 'package:anyamar/commons/constants.dart';
import 'package:anyamar/data/data_sets/avatar_colors.dart';
import 'package:anyamar/data/models/users/app_user.dart';
import 'package:anyamar/data/services/app_user_service.dart';
import 'package:anyamar/data/services/db_user_service.dart';
import 'package:anyamar/utils/loader/lazy_loader_util.dart';
import 'package:anyamar/utils/snackbar/snackbar_util.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/dashboard_page_shell.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/single_tenant/info_tile.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/buttons/card_button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_field_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Color? backgroundColor;
  bool isUpdateMode = false;

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    userEmailController.dispose();
    userPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUserAsync = ref.watch(appUserProvider);
    //
    return appUserAsync.when(
      data: (AppUser? appUser) {
        if (appUser == null) {
          return const Text('User not found');
        }
        //Controllers
        userNameController.text = appUser.userName;
        userEmailController.text = appUser.userEmail;
        userPhoneController.text = appUser.userPhoneNumber != null
            ? appUser.userPhoneNumber.toString()
            : '';
        return DashboardPageShell(
          introText: 'account',
          stickyWidget: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (event) {
              setState(() {
                backgroundColor = AppColorsConstant.greenColor;
              });
            },
            onExit: (event) {
              backgroundColor = null;
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 30.0),
                child: FittedBox(
                  child: CardButtonWidget(
                    buttonTitle: isUpdateMode == true
                        ? 'Go back'
                        : 'Click here to update your profile',
                    fontColor: backgroundColor,
                    onPressedCallBack: () {
                      setState(() {
                        isUpdateMode = !isUpdateMode;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          dashboardWidgets: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor:
                            avatarBackgroundColors[appUser.userName[0].length %
                                avatarBackgroundColors.length],
                        child: Text(
                          appUser.userName[0],
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            color: AppColorsConstant.whiteColor,
                            fontSize: 40,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      isUpdateMode
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormLabel(label: 'User Name', isRequired: true),
                                SizedBox(height: 6),
                                FormFieldWidget(
                                  controller: userNameController,
                                  keyboardType: TextInputType.text,
                                  hintText: 'User Name',
                                ),
                                SizedBox(height: 15),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: InfoTile(
                                    tileIcon: CupertinoIcons.person,
                                    tileTitle: 'Name',
                                    tileDescription: appUser.userName,
                                    onTapCallBack: () {},
                                  ),
                                ),
                              ],
                            ),

                      //Email
                      isUpdateMode
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormLabel(label: 'Email', isRequired: false),
                                SizedBox(height: 6),
                                FormFieldWidget(
                                  controller: userEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'Email address',
                                  isReadOnly: false,
                                ),
                                SizedBox(height: 15),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: InfoTile(
                                    tileIcon: CupertinoIcons.envelope,
                                    tileTitle: 'Email',
                                    tileDescription: appUser.userEmail,
                                    onTapCallBack: () {},
                                  ),
                                ),
                              ],
                            ),
                      //Phone number
                      isUpdateMode
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormLabel(
                                  label: 'Phone Number',
                                  isRequired: true,
                                ),
                                SizedBox(height: 6),
                                FormFieldWidget(
                                  controller: userPhoneController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  hintText: 'Phone Number',
                                  required: false,
                                ),
                                SizedBox(height: 15),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: InfoTile(
                                    tileIcon: CupertinoIcons.phone,
                                    tileTitle: 'Phone',
                                    tileDescription:
                                        appUser.userPhoneNumber != null
                                        ? appUser.userPhoneNumber.toString()
                                        : '',
                                    onTapCallBack: () {},
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 20),
                      //Update Button
                      isUpdateMode
                          ? ColorButtonWidget(
                              buttonColor: AppColorsConstant.greenColor,
                              buttonTitle: 'Update Profile',
                              fontSize: 13,
                              onPressedCallBack: () async {
                                if (_formKey.currentState!.validate()) {
                                  final LazyLoader lazyLoader = LazyLoader(
                                    context: context,
                                  );
                                  lazyLoader.showLoader();
                                  final db = DbService();
                                  final AppUser tobeUpdated = appUser.copyWith(
                                    userName: userNameController.text.trim(),
                                    userPhoneNumber: userPhoneController.text
                                        .trim(),
                                  );
                                  log(
                                    'User Name : ${tobeUpdated.userName}, User Phone : ${tobeUpdated.userEmail}',
                                  );
                                  try {
                                    final updatedUser = await db.updateUser(
                                      tobeUpdated,
                                    );
                                    ref
                                        .read(appUserProvider.notifier)
                                        .updateAppUser(updatedUser);
                                    displaySnackBar(
                                      context,
                                      'User Updated succesfully',
                                      AppColorsConstant.greenColor,
                                    );
                                    setState(() {
                                      isUpdateMode = false;
                                    });
                                  } catch (e) {
                                    displaySnackBar(
                                      context,
                                      'Error : $e',
                                      AppColorsConstant.redColor,
                                    );
                                  } finally {
                                    lazyLoader.hideLoader();
                                  }
                                }
                              },
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Text('Loading...'),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
