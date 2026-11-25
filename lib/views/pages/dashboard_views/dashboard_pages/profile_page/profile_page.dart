import 'package:anyamar/commons/exports.dart';

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
    final appData = ref.watch(userInformationProvider);
    final notifier = ref.read(userInformationProvider.notifier);
    final isDarkMode = ref.watch(themeIsDarkProvider);
    Color dialogColor = isDarkMode
        ? AppColors.darkElevatedCard
        : AppColors.lightCard;
    AppUser? appUser = appData.appUser;
    //Controllers
    userNameController.text = appUser?.userName ?? '';
    userEmailController.text = appUser?.userEmail ?? '';
    userPhoneController.text = appUser?.userPhoneNumber != null
        ? appUser!.userPhoneNumber.toString()
        : '';

    return DashboardPageStructure(
      introText: 'profile',
      pageTitle: 'My Account',
      supplementaryText: 'account details',
      introRowWidgets: [
        // ElevatedButtonWidget(
        //   buttonTitle: isUpdateMode == true
        //       ? 'Go back'
        //       : 'Click here to update your profile',
        //   isClear: true,
        //   onButtonPressedCallBack: () {
        //     setState(() {
        //       isUpdateMode = !isUpdateMode;
        //     });
        //   },
        // ),
      ],
      scrollableDashboardWidget: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor:
                        avatarBackgroundColors[appUser!.userName[0].length %
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
                  SizedBox(height: 15),
                  FormLabel(label: 'User Name', isRequired: true),
                  SizedBox(height: 6),
                  FormFieldWidget(
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    hintText: 'User Name',
                  ),
                  SizedBox(height: 15),
                  FormLabel(label: 'Email', isRequired: false),
                  SizedBox(height: 6),
                  FormFieldWidget(
                    controller: userEmailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email address',
                    isReadOnly: false,
                  ),
                  SizedBox(height: 15),
                  FormLabel(label: 'Phone Number', isRequired: true),
                  SizedBox(height: 6),
                  FormFieldWidget(
                    controller: userPhoneController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: 'Phone Number',
                    required: false,
                  ),

                  SizedBox(height: 20),
                  //Update Button
                  ElevatedButtonWidget(
                    buttonTitle: 'Update Profile',
                    buttonIcon: Icon(CupertinoIcons.pen),
                    onButtonPressedCallBack: () async {
                      if (_formKey.currentState!.validate()) {
                        final LazyLoader lazyLoader = LazyLoader(
                          context: context,
                        );
                        lazyLoader.showLoader();
                        final db = DbService();
                        final AppUser tobeUpdated = appUser.copyWith(
                          userName: userNameController.text.trim(),
                          userPhoneNumber: userPhoneController.text.trim(),
                        );
                        log(
                          'User Name : ${tobeUpdated.userName}, User Phone : ${tobeUpdated.userEmail}',
                        );
                        try {
                          AppUser? updatedUser = await db.updateUser(
                            tobeUpdated,
                          );

                          //local change
                          if (updatedUser != null) {
                            notifier.updateUser(updatedUser);

                            setState(() {
                              isUpdateMode = false;
                            });
                          }
                        } catch (e) {
                          displaySnackBar(
                            context,
                            'Error : $e',
                            dialogColor,
                            false,
                          );
                        } finally {
                          lazyLoader.hideLoader();
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
