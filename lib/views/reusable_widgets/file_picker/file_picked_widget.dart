import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/theme_provider.dart';
import 'package:anyamar/views/reusable_widgets/file_picker/file_extension_type.dart';
import 'package:anyamar/views/reusable_widgets/file_picker/remove_uploaded_file.dart';
import 'package:anyamar/views/reusable_widgets/file_picker/view_file_button.dart';

class FilePickedWidget extends ConsumerWidget {
  final PlatformFile pickedFile;

  const FilePickedWidget({super.key, required this.pickedFile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeIsDarkProvider);

    return GestureDetector(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          // color: _currentThemeMode.bgC,
          elevation: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // color: _currentThemeMode.darkMode
              //     ? appDarkModeCardColor
              //     : kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: false,
                        child: ViewFileButton(platformFile: pickedFile),
                      ),
                      RemoveUploadedFile(
                        file: pickedFile,
                        // pickedFile: pickedFile,
                        // isOldFile: isOldFile,
                      ),
                    ],
                  ),
                  //
                  //SVG
                  pickedFile.extension != null &&
                          ((pickedFile.extension == 'png') ||
                              (pickedFile.extension == 'jpg') ||
                              (pickedFile.extension == 'jpeg') ||
                              (pickedFile.extension == 'heic'))
                      //Displaying an image file
                      ? SizedBox(
                          height: 70,
                          width: 80,
                          child: Image.memory(
                            pickedFile.bytes!,
                            fit: BoxFit.contain,
                          ),
                        )
                      //The rest are document files
                      : pickedFile.extension != null &&
                            ((pickedFile.extension == 'pdf'))
                      ? const FileExtensionType(
                          path: 'assets/icons/png/docs/pdf.svg',
                        )
                      : pickedFile.extension != null &&
                            ((pickedFile.extension == 'docx') ||
                                (pickedFile.extension == 'doc'))
                      ? const FileExtensionType(
                          path: 'assets/icons/png/docs/docx.svg',
                        )
                      : pickedFile.extension != null &&
                            ((pickedFile.extension == 'txt'))
                      ? const FileExtensionType(
                          path: 'assets/icons/png/docs/txt.svg',
                        )
                      : pickedFile.extension != null &&
                                ((pickedFile.extension == 'xls')) ||
                            ((pickedFile.extension == 'xlsx'))
                      ? const FileExtensionType(
                          path: 'assets/icons/png/docs/xls.svg',
                        )
                      : pickedFile.extension != null &&
                            ((pickedFile.extension == 'zip'))
                      ? const FileExtensionType(
                          path: 'assets/icons/png/docs/zip.svg',
                        )
                      : const Icon(CupertinoIcons.doc, color: Colors.orange),
                  SizedBox(height: MediaQuery.of(context).size.height * .010),

                  Text(
                    pickedFile.name.toLowerCase(),
                    softWrap: true,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: currentThemeMode
                          ? AppColorsConstant.kWhite1
                          : Colors.blueGrey[600],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .010),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
