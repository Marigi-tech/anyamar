import 'package:anyamar/commons/exports.dart';

class AlertModal extends StatelessWidget {
  final String dialogTitle;
  final bool isDeleteModal;
  final String? dialogInformation;
  final String? recordId;

  const AlertModal({
    super.key,
    required this.dialogTitle,
    required this.isDeleteModal,
    this.dialogInformation,
    this.recordId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 6,
      constraints: BoxConstraints(maxWidth: 400, maxHeight: 500),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        isDeleteModal ? 'Delete $dialogTitle' : dialogTitle,
                        style: CustomTextStyles.cardTitleStyle.copyWith(
                          letterSpacing: 0.81,
                          fontSize: 20,
                          color: AppColorsConstant.darkBlueColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  //Flutter Svg asset goes here
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: SvgPicture.asset(
                      'assets/icons/svg/girl_question.svg',
                    ),
                  ),
                  SizedBox(height: 15),
                  //
                  isDeleteModal
                      ? Text(
                          'Are you sure you want to delete this $dialogTitle of ${dialogTitle.toLowerCase()} id : $recordId ?  \n\n'
                          'Note that this action CANNOT be undone.',
                          style: CustomTextStyles.cardDescriptionStyle.copyWith(
                            fontSize: 16.0,
                          ),
                        )
                      : Text(dialogInformation ?? ''),
                ],
              ),
            ),
          ),

          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                SizedBox(width: 15.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorsConstant.redColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
