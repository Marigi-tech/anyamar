import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/constants.dart';

class ViewFileButton extends ConsumerStatefulWidget {
  final PlatformFile platformFile;
  const ViewFileButton({super.key, required this.platformFile});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewFileButtonState();
}

class _ViewFileButtonState extends ConsumerState<ViewFileButton> {
  @override
  Widget build(BuildContext context) {
    //todo: open file url
    // Future openUrl(Uri fileUrl) async {
    //   LazyLoader lazyLoader = LazyLoader(context: context);
    //   final _url = fileUrl;
    //   if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    //     throw Exception(
    //       Future.delayed(Duration.zero).then(
    //         (value) => displayTopErrorMessage(LocaleKeys.errorTitle.tr(),
    //                 'Document could not be opened , check your connection and try again',)
    //             .show(context),
    //       ),
    //     );
    //   } else {
    //     await launchUrl(_url, mode: LaunchMode.externalApplication)
    //         .whenComplete(() => lazyLoader.hideLoader());
    //   }
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {},
          // onPressed: () => openUrl(
          //   Uri.parse(widget.platformFile.path!),
          // ),
          icon: Icon(
            Icons.file_download,
            color: AppColorsConstant.kBlue1,
            size: 18,
          ),
        ),
      ),
    );
  }
}
