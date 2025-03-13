part of 'theme.dart';

class KineticEnergyTextTheme {
  KineticEnergyTextTheme._internal({this.fontFamily = "Karla"})
    : _baseTextStyle = TextStyle(
        fontFamily: fontFamily,
        fontWeight: KineticEnergyFontWeight.regular,
        letterSpacing: -0.8,
        height: 1.2,
      );

  static final KineticEnergyTextTheme _instance =
      KineticEnergyTextTheme._internal();

  factory KineticEnergyTextTheme() {
    return _instance;
  }

  final String fontFamily;
  final TextStyle _baseTextStyle;

  TextStyle get headingText => _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: KineticEnergyFontWeight.semiBold,
  );

  TextStyle get bodyText => _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: KineticEnergyFontWeight.medium,
  );

  TextStyle get lightText => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: KineticEnergyFontWeight.regular,
  );
}
