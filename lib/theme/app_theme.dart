import 'package:flutter/material.dart';

class AppTheme {
  // New vibrant theme colors
  static const Color primaryColor = Color(0xFF2E86DE); // Bright blue
  static const Color secondaryColor = Color(0xFF54A0FF); // Light blue accent
  static const Color accentColor = Color(0xFFFF9F43); // Orange accent
  static const Color backgroundColor = Color(0xFFF5F9FC); // Light blue-white background
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF2C3E50); // Dark blue-grey
  static const Color subtitleColor = Color(0xFF7F8C8D); // Medium grey
  
  static final ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: cardColor,
      background: backgroundColor,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textColor,
      onBackground: textColor,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: accentColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      hintStyle: TextStyle(color: subtitleColor, fontSize: 16),
    ),
  );
}

class AppAnimations {
  static Duration fast = const Duration(milliseconds: 300);
  static Duration medium = const Duration(milliseconds: 500);
  static Duration slow = const Duration(milliseconds: 800);

  static Widget fadeSlideInFromBottom({required Widget child, Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? medium,
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  static Widget scaleIn({required Widget child, Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? fast,
      tween: Tween<double>(begin: 0.8, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  static Widget slideInFromRight({required Widget child, Duration? duration}) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? medium,
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(100 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }
}
