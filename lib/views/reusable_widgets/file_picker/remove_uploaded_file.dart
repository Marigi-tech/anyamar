import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/data/providers/selected_file_notifier_provider.dart';

class RemoveUploadedFile extends ConsumerWidget {
  final PlatformFile file;
  const RemoveUploadedFile({super.key, required this.file});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () =>
              ref.read(selectedFileProvider.notifier).removePickedFile(),
          // onPressed: () async => isOldFile
          //     ? ref
          //           .read(esomUserControllerProvider.notifier)
          //           .deleteUploadedDocument(esomUser, pickedFile)
          //           .whenComplete(() => cvProvider.deleteFile(pickedFile))
          //     : cvProvider.removeFile(pickedFile),
          icon: const Icon(CupertinoIcons.trash, color: Colors.red, size: 18),
        ),
      ),
    );
  }
}
