import 'package:anyamar/commons/app_theme.dart';
import 'package:anyamar/commons/exports.dart';

import 'firebase_options.dart';

//NB THIS  IS A FLUTTER WEB PROJECT
//CUSTOMISATION FOR ANDROID AND IOS WILL BE DONE IN LATER ITERATIONS

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeIsDarkProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // themeMode: ThemeMode.system,

      // theme: ThemeData(
      //   fontFamily: 'Lato',
      //   textTheme: const TextTheme(
      //     headlineLarge: TextStyle(fontFamily: 'Montserrat'),
      //     headlineMedium: TextStyle(fontFamily: 'Montserrat'),
      //     titleLarge: TextStyle(fontFamily: 'Montserrat'),
      //   ),
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: AppColorsConstant.greenColor,
      //     brightness: Brightness.light,
      //   ),
      // ),

      // darkTheme: ThemeData(
      //   fontFamily: 'Lato',
      //   textTheme: const TextTheme(
      //     headlineLarge: TextStyle(fontFamily: 'Montserrat'),
      //     headlineMedium: TextStyle(fontFamily: 'Montserrat'),
      //     titleLarge: TextStyle(fontFamily: 'Montserrat'),
      //   ),
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: AppColorsConstant.greenColor,
      //     brightness: Brightness.dark,
      //   ),
      // ),
      home: const LandingPage(),
    );
  }
}
