import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sidebar_notifier_provider.g.dart';

@riverpod
class SideBarNotifier extends _$SideBarNotifier {
  @override
  bool build() {
    return true; // Sidebar is visible by default
  }

  void toggleSidebar() {
    state = !state;
  }

  void hideSidebar() {
    state = false;
  }

  void showSidebar() {
    state = true;
  }
}
