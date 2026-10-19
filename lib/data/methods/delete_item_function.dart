import 'package:anyamar/commons/exports.dart';

void deleteItemFunction(
  BuildContext context,
  String itemDescription,
  String item,
  deleteFunction,
) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialogWidget(
        dialogContext: dialogContext,
        itemDescription: itemDescription,
        item: item,
        deleteFunction: deleteFunction,
      );
    },
  );
}

class AlertDialogWidget extends ConsumerWidget {
  final BuildContext dialogContext;
  final String itemDescription;
  final String item;
  final Future<void> deleteFunction;
  const AlertDialogWidget({
    super.key,
    required this.dialogContext,
    required this.itemDescription,
    required this.item,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return AlertDialog(
      title: Text(
        'Delete $itemDescription',
        style: AppTextStylesConstant.cardDescriptionStyle.copyWith(
          fontStyle: FontStyle.normal,
          fontSize: 17,
          color: themeIsDark == true ? AppColors.darkText : AppColors.lightText,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: SvgPicture.asset('assets/icons/svg/girl_question.svg'),
            ),
          ),

          SizedBox(height: 10),
          Text(
            'Are you sure you want to delete '
            '$item ? '
            'This action cannot be undone.',
            style: AppTextStylesConstant.cardDescriptionStyle.copyWith(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              color: themeIsDark == true
                  ? AppColors.darkText
                  : AppColors.lightText,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: themeIsDark == true
                ? AppColors.darkCard
                : AppColors.lightCard,
          ),
          onPressed: () async {
            Navigator.of(dialogContext).pop();

            await deleteFunction;
          },
          child: Text(
            'Delete',
            style: AppTextStylesConstant.cardDescriptionStyle.copyWith(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              color: themeIsDark == true
                  ? AppColors.darkText
                  : AppColors.lightText,
            ),
          ),
        ),
      ],
    );
  }
}
