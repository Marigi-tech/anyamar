import 'package:anyamar/commons/exports.dart';

class WebFormWidget extends StatelessWidget {
  final Widget form;
  final String formTitle;
  final bool? hasSocialOptions;
  const WebFormWidget({
    super.key,
    required this.form,
    required this.formTitle,
    this.hasSocialOptions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.0),
                Align(alignment: Alignment.topLeft, child: BackButton()),
                Text(
                  formTitle,
                  style: CustomTextStyles.cardDescriptionStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Expanded(child: form),
                // Visibility(
                //   visible: hasSocialOptions == true ? true : false,

                //   child: Padding(
                //     padding: EdgeInsets.only(bottom: 10.0),
                //     child: SignWithSocials(),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
