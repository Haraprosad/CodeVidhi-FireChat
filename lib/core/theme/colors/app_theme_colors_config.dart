import 'package:flutter/material.dart';
import 'package:codevidhi_firechat/core/theme/base/app_theme_type.dart';
import 'package:codevidhi_firechat/core/theme/colors/theme_colors.dart';

class AppThemeColorsConfig {
  // Status Colors (same for both themes)
  static const Color _warning = Color(0xFFFFC107);
  static const Color _alert = Color(0xFFFF9800);

  // Theme color schemes
  static final Map<AppThemeType, ThemeColors> themeColors = {
    AppThemeType.light: ThemeColors(
      primary: const Color(0xFF0084FF), // Messenger blue
      secondary: const Color(0xFFFF4081),
      success: const Color(0xFF00C853),
      background: const Color(0xFFFAFAFA), // Subtle light gray
      surface: const Color(0xFFFFFFFF), // Pure white
      textPrimary: const Color(0xFF050505),
      textSecondary: const Color(0xFF65676B),
      warning: _warning,
      alert: _alert,
      chatOutgoingBubble: const Color(0xFF0084FF), // Messenger blue
      chatIncomingBubble: const Color(0xFFF0F2F5), // Lighter gray for bubbles
    ),
    AppThemeType.dark: ThemeColors(
      primary: const Color(0xFF0084FF), // Messenger blue
      secondary: const Color(0xFFFF4081),
      success: const Color(0xFF00C853),
      background: const Color(0xFF1A1B1E), // Softer dark background
      surface: const Color(0xFF2D2F34), // Elevated dark surface
      textPrimary: const Color(0xFFE4E6EB),
      textSecondary: const Color(0xFFB0B3B8),
      warning: _warning,
      alert: _alert,
      chatOutgoingBubble: const Color(0xFF0084FF), // Messenger blue
      chatIncomingBubble: const Color(0xFF3E4042), // Softer dark gray
    ),
  };
}
