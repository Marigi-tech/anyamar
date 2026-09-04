import 'package:anyamar/data/providers/theme_provider.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/dashboard_page_shell.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/single_tenant/info_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeIsDarkProvider);
    return DashboardPageShell(
      introText: 'settings',

      dashboardWidgets: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        tileIcon: CupertinoIcons.gear,
                        tileTitle: 'Theme',
                        tileDescription:
                            'Current Theme : ${isDark == true ? 'Dark' : 'Light'} ',
                        onTapCallBack: () {
                          ref.read(themeIsDarkProvider.notifier).toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
