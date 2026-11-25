import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_page_notifier.g.dart';

@riverpod
class SelectedPageNotifier extends _$SelectedPageNotifier {
  @override
  int build() {
    return 0;
  }

  /// Select a page using its index.
  Future<void> selectPage(int pageIndex) async {
    if (pageIndex < 0) return;

    state = pageIndex;
  }

  /// Return to the default page.
  void resetPage() {
    state = 0;
  }
}
