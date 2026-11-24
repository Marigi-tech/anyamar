import 'package:anyamar/commons/app_theme.dart';
import 'package:anyamar/commons/exports.dart';

import 'firebase_options.dart';
import 'package:web/web.dart' as web;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final splash = web.document.getElementById('splash-content');

    splash?.classList.add('fade-out');

    Future.delayed(const Duration(milliseconds: 400), () {
      splash?.remove();
      web.document.body?.classList.remove('splash');
    });
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeIsDarkProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark != true ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const LandingPage(),
    );
  }
}
