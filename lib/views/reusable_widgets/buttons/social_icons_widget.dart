import 'package:anyamar/commons/exports.dart';

class SocialIconButtonWidget extends ConsumerStatefulWidget {
  final SocialIconModel socialIcon;
  const SocialIconButtonWidget({super.key, required this.socialIcon});

  @override
  ConsumerState<SocialIconButtonWidget> createState() =>
      _SocialIconButtonWidgetState();
}

class _SocialIconButtonWidgetState
    extends ConsumerState<SocialIconButtonWidget> {
  bool isHovered = false;
  Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = ref.watch(themeIsDarkProvider);
    Color dialogColor = isDark
        ? AppColors.darkElevatedCard
        : AppColors.lightCard;

    bgColor = isHovered
        ? AppColors.primaryBlue
        : isDark
        ? AppColors.darkElevatedCard.withValues(alpha: 0.85)
        : AppColors.lightCard.withValues(alpha: 0.85);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },

      child: GestureDetector(
        onTap: () async {
          try {
            final userCredential = await ref
                .read(authServiceProvider)
                .authenticateWithGoogle();

            final user = userCredential.user;

            if (user != null) {
              // Authentication and Firestore profile initialization succeeded.
            }
          } on FirebaseAuthException catch (e) {
            // Handle Firebase authentication errors.
            displaySnackBar(context, 'Error : $e', dialogColor, false);
          } catch (e) {
            // Handle other errors.
            displaySnackBar(context, 'Error : $e', dialogColor, false);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),

          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: !isDark ? AppColors.lightBorder : AppColors.darkBorder,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                widget.socialIcon.iconPath,
                width: 13,
                height: 13,
              ),
              SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  child: Text(
                    widget.socialIcon.iconName,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.cardDescriptionStyle.copyWith(
                      fontSize: 13.0,
                      fontStyle: FontStyle.normal,
                      color: isHovered ? AppColors.whiteColor : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
