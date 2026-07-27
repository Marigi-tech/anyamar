import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/views/reusable_widgets/sidebar_widget/collapsed_side_item.dart';
import 'package:anyamar/views/reusable_widgets/sidebar_widget/uncollapsed_side_item.dart';

class SideBarItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressedCallBack;
  final int? index;
  final BoxDecoration? backgroundColor;
  final bool? isLogOutButton;

  const SideBarItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.index,
    this.onPressedCallBack,
    this.backgroundColor,
    this.isLogOutButton,
  });

  @override
  Widget build(BuildContext context) {
    return isSidebarCollapsedNotifier.value == true
        ? CollapsedSideItem(
            title: title,
            icon: icon,
            isLogOutButton: isLogOutButton,
            onPressedCallBack: onPressedCallBack,
            index: index,
          )
        : UncollapsedSideItem(
            title: title,
            icon: icon,
            isLogOutButton: isLogOutButton,
            onPressedCallBack: onPressedCallBack,
            index: index,
          );
  }
}
