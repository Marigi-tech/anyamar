import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_workspace/workspace_view.dart';
import 'package:anyamar/views/pages/widget_tree/pages_list/pages_list.dart';

class MainWorkspace extends ConsumerWidget {
  const MainWorkspace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageProvider);
    final workspaceView = ref.watch(workspaceProvider);

    // A temporary form or workspace takes priority.
    if (workspaceView case WidgetWorkspaceView(:final child)) {
      return child;
    }

    // Otherwise, display the selected sidebar page.
    if (selectedPage < 0 || selectedPage >= webPages.length) {
      return const Center(child: Text('Page not found'));
    }

    return webPages[selectedPage];
  }
}

