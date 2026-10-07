import 'package:anyamar/commons/exports.dart';

class AppTheme {
  AppTheme._();
  // ========================================================
  // Light Theme
  // ========================================================
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Lato',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.darkBlue,
      surface: AppColors.lightCard,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightText,
      onError: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightCard,
      foregroundColor: AppColors.lightText,
      elevation: 0,
      centerTitle: false,
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightCard,
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.lightBorder,
      thickness: 1,
    ),
    // inputDecorationTheme: CustomInputDecoration.textInputDecoration(
    //   fillColor: AppColors.lightCard,
    // ),

    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: Colors.white,
    //   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: const BorderSide(color: AppColors.lightBorder),
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: const BorderSide(color: AppColors.lightBorder),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
    //   ),
    // ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.w700,
      ),

      headlineMedium: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.w700,
      ),

      titleLarge: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.w600,
      ),

      titleMedium: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.w600,
      ),

      bodyLarge: TextStyle(color: AppColors.lightText),

      bodyMedium: TextStyle(color: AppColors.lightSecondaryText),
    ),
  );
  // ========================================================
  // Dark Theme
  // ========================================================
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Lato',
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF3B82F6),
      secondary: Color(0xFF60A5FA),
      surface: AppColors.darkCard,
      error: AppColors.darkError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.darkText,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkCard,
      foregroundColor: AppColors.darkText,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 1,
    ),
    // inputDecorationTheme: CustomInputDecoration.textInputDecoration(
    //   fillColor: AppColors.darkCard,
    // ),

    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: AppColors.darkElevatedCard,
    //   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: const BorderSide(color: AppColors.darkBorder),
    //   ),

    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: const BorderSide(color: AppColors.darkBorder),
    //   ),

    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
    //   ),
    // ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w700,
      ),

      headlineMedium: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w700,
      ),

      titleLarge: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w600,
      ),

      titleMedium: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w600,
      ),

      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkSecondaryText),
    ),
  );
}
