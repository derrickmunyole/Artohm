import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

/// Helper class for managing themes and colors.
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    PrefUtils().setThemeData(_newTheme);
    Get.forceAppUpdate();
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.whiteA700,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.black90001.withOpacity(0.08),
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.black90001,
          fontSize: 16.fSize,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.black90001,
          fontSize: 14.fSize,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.black90001,
          fontSize: 9.fSize,
          fontFamily: 'Libre Baskerville',
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: appTheme.black90001.withOpacity(0.87),
          fontSize: 12.fSize,
          fontFamily: 'Libre Baskerville',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: appTheme.black90001,
          fontSize: 10.fSize,
          fontFamily: 'Libre Baskerville',
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: appTheme.black90001.withOpacity(0.8),
          fontSize: 20.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: appTheme.black90001,
          fontSize: 16.fSize,
          fontFamily: 'Libre Baskerville',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: appTheme.black90001,
          fontSize: 14.fSize,
          fontFamily: 'Libre Baskerville',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFFFF6B88),
    primaryContainer: Color(0XFF1C274C),
    secondary: Color(0XFF1C274C),
    secondaryContainer: Color(0X14FF6B88),
    tertiary: Color(0XFF1C274C),
    tertiaryContainer: Color(0X14FF6B88),

    // Background colors
    background: Color(0XFF1C274C),

    // Surface colors
    surface: Color(0XFF1C274C),
    surfaceTint: Color(0XFF231F20),
    surfaceVariant: Color(0X14FF6B88),

    // Error colors
    error: Color(0XFF231F20),
    errorContainer: Color(0X3F407BFF),
    onError: Color(0XFFFFD561),
    onErrorContainer: Color(0XFF231F20),

    // On colors(text colors)
    onBackground: Color(0XFFD9D9D9),
    onInverseSurface: Color(0XFFFFD561),
    onPrimary: Color(0XFF231F20),
    onPrimaryContainer: Color(0XFFD9D9D9),
    onSecondary: Color(0XFFD9D9D9),
    onSecondaryContainer: Color(0XFF231F20),
    onTertiary: Color(0XFFD9D9D9),
    onTertiaryContainer: Color(0XFF231F20),

    // Other colors
    outline: Color(0XFF231F20),
    outlineVariant: Color(0XFF1C274C),
    scrim: Color(0XFF1C274C),
    shadow: Color(0XFF231F20),

    // Inverse colors
    inversePrimary: Color(0XFF1C274C),
    inverseSurface: Color(0XFF231F20),

    // Pending colors
    onSurface: Color(0XFFD9D9D9),
    onSurfaceVariant: Color(0XFF231F20),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Amber
  Color get amber300 => Color(0XFFFFD561);

  // Black
  Color get black900 => Color(0XFF0F0404);
  Color get black90001 => Color(0XFF000000);
  Color get black90033 => Color(0X33030303);

  // Blue
  Color get blue50 => Color(0XFFEAF4FF);

  // BlueGray
  Color get blueGray100 => Color(0XFFCECECE);
  Color get blueGray10001 => Color(0XFFD9D9D9);
  Color get blueGray400 => Color(0XFF888888);
  Color get blueGray700 => Color(0XFF515151);
  Color get blueGray900 => Color(0XFF263238);

  // DeepOrange
  Color get deepOrange50 => Color(0XFFFDE8E8);

  // Gray
  Color get gray100 => Color(0XFFF5F5F5);
  Color get gray200 => Color(0XFFEBEBEB);
  Color get gray400 => Color(0XFFC0BFBF);
  Color get gray40001 => Color(0XFFB9B2B2);
  Color get gray50 => Color(0XFFFCFCFC);
  Color get gray500 => Color(0XFFABA8A8);
  Color get gray50001 => Color(0XFFA7A7A7);
  Color get gray900 => Color(0XFF231F20);
  Color get gray90014 => Color(0X14212121);
  Color get gray90033 => Color(0X33212121);

  // Green
  Color get greenA700 => Color(0XFF00AC47);

  // LightBlue
  Color get lightBlueA700 => Color(0XFF007BFF);

  // Pink
  Color get pink50 => Color(0XFFFFE6EB);
  Color get pink5001 => Color(0XFFFFE7EC);
  Color get pink5002 => Color(0XFFFFE5EA);

  // Red
  Color get red300 => Color(0XFFD45971);
  Color get red30044 => Color(0X44DF7E7E);

  // White
  Color get whiteA700 => Color(0XFFFFFFFF);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
