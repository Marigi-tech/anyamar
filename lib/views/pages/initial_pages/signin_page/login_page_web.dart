import 'package:anyamar/commons/exports.dart';

import 'package:anyamar/forms/login_page_form.dart';

class LogInPageWeb extends ConsumerStatefulWidget {
  const LogInPageWeb({super.key});

  @override
  ConsumerState<LogInPageWeb> createState() => _LogInPageWebState();
}

class _LogInPageWebState extends ConsumerState<LogInPageWeb> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsiveness.isMobile(context);
    bool isDarkMode = ref.watch(themeIsDarkProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (isMobile)
        CustomBackButton(
          color: isDarkMode ? AppColors.darkElevatedCard : AppColors.lightCard,
          // color: isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),

        // SizedBox(height: 10.0),
        isMobile
            ? LogInPageForm()
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.0, top: 10.0),
                      height: MediaQuery.of(context).size.height * .85,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bg.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.35,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryBlue,
                            BlendMode.dstOver,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                  ),
                  SizedBox(width: 50.0),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: LogInPageForm(),
                    ),
                  ),
                  Expanded(flex: 2, child: SizedBox()),
                ],
              ),
      ],
    );
  }
}
