import 'package:anyamar/commons/exports.dart';

class FormShellWeb extends ConsumerStatefulWidget {
  final VoidCallback? onSignIn;
  final VoidCallback? onCreateAccount;
  final Widget webForm;
  final bool photoRight;
  final String? imageAsset;

  const FormShellWeb({
    super.key,
    this.onSignIn,
    this.onCreateAccount,
    required this.webForm,
    required this.photoRight,
    this.imageAsset,
  });

  @override
  ConsumerState<FormShellWeb> createState() => _FormShellWebState();
}

class _FormShellWebState extends ConsumerState<FormShellWeb> {
  static const Color primary = Color(0xFF159B91);
  static const Color darkText = Color(0xFF202C32);
  static const Color mutedText = Color(0xFF899297);
  late Color backgroundColor;
  late Color containerColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = ref.watch(themeIsDarkProvider);
    final bool isMobile = Responsiveness.isMobile(context);
    backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColorsConstant.kPrimaryColor;

    containerColor = isDark ? AppColors.darkElevatedCard : AppColors.lightCard;
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColors.buttonBlueColor.withValues(alpha: 0.95),
                AppColors.buttonBlueColor.withValues(alpha: 0.45),
                AppColors.buttonBlueColor.withValues(alpha: 0.045),
                backgroundColor.withValues(alpha: 0.025),
                backgroundColor.withValues(alpha: 0.25),
                backgroundColor.withValues(alpha: 0.95),
                backgroundColor.withValues(alpha: 0.25),
                backgroundColor.withValues(alpha: 0.025),
                AppColors.buttonBlueColor.withValues(alpha: 0.045),
                AppColors.buttonBlueColor.withValues(alpha: 0.45),
                AppColors.buttonBlueColor.withValues(alpha: 0.95),
                // AppColors.buttonBlueColor.withValues(alpha: 0.45),
                // AppColors.buttonBlueColor.withValues(alpha: 0.0045),
                // AppColors.buttonBlueColor.withValues(alpha: 0.95),
              ],
              stops: const [
                0.0,
                0.09,
                0.18,
                0.24,
                0.31,
                0.42,
                0.58,
                0.65,
                0.73,
                0.88,
                1.0,
              ],
            ),
          ),

          child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP LAYOUT
  // ============================================================

  Widget _buildDesktopLayout() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: Container(
          height: MediaQuery.of(context).size.height * .90,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.09),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: widget.photoRight
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Registration form
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [CustomBackButton(), ThemeToggleWidget()],
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(left: 50.0, top: 10.0),
                              child: widget.webForm,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                    // Image section
                    Expanded(flex: 6, child: _buildImageSection()),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Image section
                    Expanded(flex: 6, child: _buildImageSection()),
                    Expanded(flex: 1, child: SizedBox()),

                    Expanded(
                      flex: 5,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(left: 50.0, top: 10.0),
                        child: widget.webForm,
                      ),
                    ),
                    //   ],
                    // ),
                    // ),
                    Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE LAYOUT
  // ============================================================

  Widget _buildMobileLayout() {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBackButton(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: widget.webForm,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // IMAGE SECTION
  // ============================================================

  Widget _buildImageSection() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          widget.imageAsset ?? 'assets/images/cbd.jpg',
          colorBlendMode: BlendMode.dstOver,
          color: primary.withValues(alpha: 0.085),
          fit: BoxFit.fitHeight,

          errorBuilder: (_, __, ___) {
            return Container(
              color: const Color(0xFF345A58),
              child: const Icon(
                Icons.apartment_rounded,
                size: 100,
                color: Colors.white38,
              ),
            );
          },
        ),

        // Image overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryBlue.withValues(alpha: 0.05),
                Colors.black.withValues(alpha: 0.40),
              ],
            ),
          ),
        ),
        //==========================================
        //BACK BUTTON
        //======================================
        if (widget.photoRight != true)
          Positioned(top: 10, left: 10, child: CustomBackButton()),
        //=====================================================
        //THEME TOGGLE WIDGET
        //=====================================================
        if (widget.photoRight != true)
          Positioned(top: 10, right: 10, child: ThemeToggleWidget()),

        // =============================================
        // LOGO WIDGET
        //==============================================
        Positioned(
          top: 20,
          right: 185,
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.apartment_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'ANYAMAR',
                style: CustomTextStyles.cardDescriptionStyle.copyWith(
                  color: AppColors.darkText,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 62,
          bottom: 105,
          child: Container(
            padding: const EdgeInsets.all(17),
            width: 239,
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(17),
            ),
            child: SizedBox(
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wallet, color: primary, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Automated Payments',
                        style: CustomTextStyles.cardDescriptionStyle.copyWith(
                          color: mutedText,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 45,
          bottom: 65,
          child: Container(
            padding: const EdgeInsets.all(17),
            width: 239,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(17),
            ),
            child: SizedBox(height: 60),
          ),
        ),

        // Floating property information
        Positioned(
          left: 25,
          bottom: 35,
          child: Container(
            padding: const EdgeInsets.all(17),
            width: 235,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.home_work_rounded, color: primary, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Property management..',
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        color: mutedText,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Everything in one place.',
                  style: TextStyle(
                    color: darkText,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Properties, tenants and finances.',
                  style: TextStyle(color: mutedText, fontSize: 10),
                ),
              ],
            ),
          ),
        ),

        // Floating status card
        Positioned(
          top: 90,
          right: 22,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay organised',
                  style: TextStyle(
                    color: darkText,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 06),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, color: primary, size: 17),
                    SizedBox(width: 8),
                    Text(
                      'Tenant records',
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        color: darkText,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 06),
                Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: primary, size: 17),
                    SizedBox(width: 8),
                    Text(
                      'Property records',
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        color: darkText,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 06),
                Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: primary, size: 17),
                    SizedBox(width: 8),
                    Text(
                      'Rental records',
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        color: darkText,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 06),
                Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: primary, size: 17),
                    SizedBox(width: 8),
                    Text(
                      'Expense records',
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        color: darkText,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
