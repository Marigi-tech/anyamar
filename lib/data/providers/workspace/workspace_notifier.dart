import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_workspace/workspace_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_notifier.g.dart';

// @riverpod
// class WorkspaceNotifier extends _$WorkspaceNotifier {
//   @override
//   WorkspaceView? build() => null;

//   void openForm(Widget form) {
//     state = WidgetWorkspaceView(form);
//   }

//   void closeWorkspace() {
//     state = null;
//   }
// }
@riverpod
class WorkspaceNotifier extends _$WorkspaceNotifier {
  final List<WorkspaceView?> _history = [];

  @override
  WorkspaceView? build() => null;

  void openForm(Widget form) {
    _history.add(state);
    state = WidgetWorkspaceView(form);
  }

  void closeWorkspace() {
    if (_history.isEmpty) {
      state = null;
      return;
    }

    state = _history.removeLast();
  }

  void clearWorkspace() {
    _history.clear();
    state = null;
  }
}
