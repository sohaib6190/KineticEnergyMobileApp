part of 'theme.dart';

class KineticEnergyTheme {
  KineticEnergyTheme._internal({
    KineticEnergyColorTheme? kineticEnergyColorTheme,
    KineticEnergyTextTheme? kineticEnergyTextTheme,
  }) : _kineticColorTheme =
           kineticEnergyColorTheme ?? KineticEnergyColorTheme(),
       _kineticTextTheme = kineticEnergyTextTheme ?? KineticEnergyTextTheme();

  static final KineticEnergyTheme _instance = KineticEnergyTheme._internal();

  factory KineticEnergyTheme() {
    return _instance;
  }

  final KineticEnergyColorTheme _kineticColorTheme;
  final KineticEnergyTextTheme _kineticTextTheme;

  ThemeData get darkThemeData => ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    brightness: Brightness.dark,
    primaryColor: _kineticColorTheme.primary,
    fontFamily: _kineticTextTheme.fontFamily,
    inputDecorationTheme: inputDecorationThemeData,
    iconTheme: iconThemeData,
    listTileTheme: listTileThemeData,
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: _kineticColorTheme.darkBackground,
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonThemeData,
    dividerTheme: dividerTheme,
    datePickerTheme: darkDatePickerTheme,
  );

  ThemeData get lightThemeData => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    primaryColor: _kineticColorTheme.primary,
    fontFamily: _kineticTextTheme.fontFamily,
    inputDecorationTheme: inputDecorationThemeData,
    iconTheme: iconThemeData,
    listTileTheme: listTileThemeData,
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: _kineticColorTheme.lightBackground,
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonThemeData,
    dividerTheme: dividerTheme,
    datePickerTheme: lightDatePickerTheme,
  );

  ColorScheme get lightColorScheme => const ColorScheme.light().copyWith(
    primary: _kineticColorTheme.primary,
    secondary: _kineticColorTheme.secondary,
    surfaceTint: Colors.transparent,
  );

  ColorScheme get darkColorScheme => const ColorScheme.dark().copyWith(
    primary: _kineticColorTheme.primary,
    secondary: _kineticColorTheme.secondary,
    surfaceTint: Colors.transparent,
  );

  IconThemeData get iconThemeData =>
      IconThemeData(color: _kineticColorTheme.primary);

  ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      );

  OutlinedButtonThemeData get outlinedButtonThemeData =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      );

  ListTileThemeData get listTileThemeData =>
      ListTileThemeData(iconColor: _kineticColorTheme.primary);

  InputDecorationTheme get inputDecorationThemeData => InputDecorationTheme(
    iconColor: _kineticColorTheme.primary,
    hintStyle: TextStyle(
      fontFamily: "Karla",
      fontSize: 18,
      fontWeight: KineticEnergyFontWeight.medium,
      letterSpacing: -0.8,
      height: 1.2,
      color: _kineticColorTheme.secondary,
    ),
    labelStyle: TextStyle(
      fontFamily: "Karla",
      fontSize: 18,
      fontWeight: KineticEnergyFontWeight.medium,
      letterSpacing: -0.8,
      height: 1.2,
      color: _kineticColorTheme.secondary,
    ),
  );

  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    foregroundColor: _kineticColorTheme.primary,
    elevation: 0,
  );

  DividerThemeData get dividerTheme => DividerThemeData(
    color: _kineticColorTheme.lightGrey,
    space: 0,
    thickness: 1,
  );

  DatePickerThemeData get darkDatePickerTheme =>
      DatePickerThemeData(backgroundColor: _kineticColorTheme.secondary);

  DatePickerThemeData get lightDatePickerTheme =>
      DatePickerThemeData(backgroundColor: _kineticColorTheme.lightBackground);
}
