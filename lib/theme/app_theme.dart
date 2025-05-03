import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1E293B);
  static const Color accentColor = Color(0xFFFF9500);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF2D3142);
  static const Color subtitleColor = Color(0xFF6B7280);
  
  static final ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
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
