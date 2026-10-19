
import 'package:anyamar/commons/exports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_page_notifier.g.dart';

@riverpod
class SelectedPageNotifier extends _$SelectedPageNotifier {
  @override
  int build() {
    return 0;
  }

  /// Select a page using its index.
  void selectPage(int pageIndex) {
    if (pageIndex < 0) return;

    state = pageIndex;
  }

  /// Return to the default page.
  void resetPage() {
    state = 0;
  }
}
