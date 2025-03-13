part of 'theme.dart';

class KineticEnergyColorTheme {
  // Private constructor
  KineticEnergyColorTheme._internal();

  // The single instance
  static final KineticEnergyColorTheme _instance =
      KineticEnergyColorTheme._internal();

  // Factory constructor to return the same instance
  factory KineticEnergyColorTheme() {
    return _instance;
  }

  // Color definitions
  Color get primary => const Color(0xFF56B9F2);
  Color get secondary => const Color(0xFF35363A);
  Color get darkBackground => const Color(0xFF0E0E0E);
  Color get lightBackground => const Color(0xFFF0F0F0);
  Color get black => const Color(0xFF000000);
  Color get black20 => const Color(0xFF202020);
  Color get black40 => const Color(0xFF22272B);
  Color get white => const Color(0xFFFFFFFF);
  Color get lightGrey => const Color(0xFFD9D9D9);
  Color get lightGrey50 => const Color(0xffA4A6B0);
  Color get lightGrey80 => const Color(0xFFE2E3E6);
  Color get lightGrey70 => const Color(0xFFE5E5E5);

  Color get yellow => const Color(0xFFFBE571);
  Color get red => const Color(0xFFFF0000);
  Color get green => const Color(0xFF4BB543);
  Color get purple => const Color(0xFFA020F0);
  Color get blue => const Color.fromARGB(255, 25, 162, 241);
  Color get lightBlue => const Color(0xFF56B9F2);
  Color get blackShade => const Color(0xFF202020);
  Color get darkBrown => const Color.fromARGB(166, 78, 41, 30);
  Color get greyshade1 => const Color.fromARGB(255, 67, 68, 73);
  Color get darkGrey => const Color.fromARGB(255, 32, 33, 36);
  Color get orange => const Color(0xffFF6801);
  Color get lightShimmerBaseColor => Colors.grey[300]!;
  Color get lightShimmerHighlightColor => Colors.grey[100]!;
  Color get darkShimmerBaseColor => Colors.grey[800]!;
  Color get darkShimmerHighlightColor => Colors.grey[600]!;
  Color get primaryGradient1 => const Color(0xFF004999);
  Color get primaryGradient2 => const Color(0xFF00EFEB);

  // Gradient definition
  LinearGradient get primaryGradient => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryGradient1, primaryGradient2],
  );
}
