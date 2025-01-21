import 'package:flutter/foundation.dart';

@immutable
class RouteNames {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String register = 'register';
  
  // Main Routes
  static const String chats = 'chats';
  static const String settings = 'settings';
  
  // Nested Routes
  static const String conversation = 'conversation';
  
  // Profile Routes
  static const String editProfile = 'editProfile';
  
  const RouteNames._();
}