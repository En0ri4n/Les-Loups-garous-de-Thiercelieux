
import 'dart:ui';

class ThemeColor {

  late Color primaryColor;
  late Color secondaryColor;

  late Color primaryTextColor;
  late Color secondaryTextColor;

  late Color primaryButtonColor;
  late Color secondaryButtonColor;

  late Color primaryButtonTextColor;
  late Color secondaryButtonTextColor;

  late Color primaryBackgroundColor;
  late Color secondaryBackgroundColor;

  ThemeColor({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.primaryButtonColor,
    required this.secondaryButtonColor,
    required this.primaryButtonTextColor,
    required this.secondaryButtonTextColor,
    required this.primaryBackgroundColor,
    required this.secondaryBackgroundColor,
  });
}

class ColorHelper {
  static final ThemeColor lightTheme = ThemeColor(
    primaryColor: Color(0xFF6200EE),
    secondaryColor: Color(0xFF03DAC6),
    primaryTextColor: Color(0xFF000000),
    secondaryTextColor: Color(0xFF757575),
    primaryButtonColor: Color(0xFF6200EE),
    secondaryButtonColor: Color(0xFF03DAC6),
    primaryButtonTextColor: Color(0xFFFFFFFF),
    secondaryButtonTextColor: Color(0xFF000000),
    primaryBackgroundColor: Color(0xFFFFFFFF),
    secondaryBackgroundColor: Color(0xFFF5F5F5),
  );

  static final ThemeColor darkTheme = ThemeColor(
    primaryColor: Color(0xFFBB86FC),
    secondaryColor: Color(0xFF03DAC6),
    primaryTextColor: Color(0xFFFFFFFF),
    secondaryTextColor: Color(0xFFB0BEC5),
    primaryButtonColor: Color(0xFFBB86FC),
    secondaryButtonColor: Color(0xFF03DAC6),
    primaryButtonTextColor: Color(0xFF000000),
    secondaryButtonTextColor: Color(0xFFFFFFFF),
    primaryBackgroundColor: Color(0xFF121212),
    secondaryBackgroundColor: Color(0xFF1E1E1E),
  );
}