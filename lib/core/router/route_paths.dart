import 'package:flutter/foundation.dart';

@immutable
class RoutePaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  
  // Main Routes with Bottom Navigation
  static const String users = '/users';
  static const String chats = '/chats';
  static const String settings = '/settings';
  
  // Nested Routes
  static const String conversation = 'conversation/:userId';

  
  // Profile Routes
  static const String editProfile = 'edit';
  
  const RoutePaths._();
}