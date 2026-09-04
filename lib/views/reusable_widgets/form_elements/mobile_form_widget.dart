import 'package:anyamar/commons/exports.dart';

class MobileFormWidget extends StatelessWidget {
  final Widget form;
  final String formTitle;
  final bool? hasSocialOptions;
  const MobileFormWidget({
    super.key,
    required this.form,
    required this.formTitle,
    this.hasSocialOptions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomBackButton(),
          Text(
            formTitle,
            style: CustomTextStyles.cardDescriptionStyle,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20.0),

          Expanded(child: form),
          // Visibility(
          //   visible: hasSocialOptions == true ? true : false,

          //   child: SignWithSocials(),
          // ),
        ],
      ),
    );
  }
}
