import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_file_notifier_provider.g.dart';

@riverpod
class SelectedFileNotifier extends _$SelectedFileNotifier {
  @override
  PlatformFile? build() {
    return null;
  }

  void fetchPickedFile(PlatformFile pickedFile) {
    state = pickedFile;
  }

  void removePickedFile() {
    state = null;
  }
}
