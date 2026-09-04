import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/selected_file_notifier_provider.dart';
import 'package:anyamar/views/reusable_widgets/icons/base_icon.dart';
import 'package:dotted_border/dotted_border.dart';

class FilePickerWidget extends ConsumerWidget {
  final bool isImage;
  final String? uploadText;
  const FilePickerWidget({super.key, required this.isImage, this.uploadText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: DottedBorder(
              ignoring: true,
              childOnTop: false,
              options: RectDottedBorderOptions(
                color: AppColorsConstant.kBlue1,
                strokeWidth: 1,
                stackFit: StackFit.loose,
                strokeCap: StrokeCap.round,
                dashPattern: const [5, 7],
              ),

              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                            allowMultiple: isImage ? false : true,
                            withData: true,
                            withReadStream: false,
                            type: isImage ? FileType.image : FileType.any,
                          );

                      if (result != null) {
                        ref
                            .read(selectedFileProvider.notifier)
                            .fetchPickedFile(result.files.single);
                      }
                    },

                    // },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BaseIcon(
                            iconFileName: 'upload-icon.svg',
                            color: AppColorsConstant.kBlue1,
                            height: 15,
                          ),
                          Text(
                            uploadText ??
                                'Click here to upload your  ${isImage ? 'Image' : 'document(s)'},',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.cardDescriptionStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
