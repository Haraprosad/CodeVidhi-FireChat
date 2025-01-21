import 'package:codevidhi_firechat/features/chats/presentation/pages/chats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codevidhi_firechat/core/router/navigator_keys.dart';
import 'package:codevidhi_firechat/core/router/route_names.dart';
import 'package:codevidhi_firechat/core/router/route_paths.dart';
import 'package:codevidhi_firechat/core/widgets/scaffold_with_bottom_nav.dart';

import 'package:codevidhi_firechat/features/dlt_auth/presentation/pages/login_screen.dart';
import 'package:codevidhi_firechat/features/dlt_auth/presentation/pages/register_screen.dart';
import 'package:codevidhi_firechat/features/dlt_auth/presentation/pages/splash_screen.dart';
import 'package:codevidhi_firechat/features/dlt_profile/presentation/pages/edit_profile_screen.dart';
import 'package:codevidhi_firechat/features/dlt_profile/presentation/pages/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppRoutes {
  List<RouteBase> get routes => [
        GoRoute(
          path: RoutePaths.splash,
          name: RouteNames.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RoutePaths.register,
          name: RouteNames.register,
          builder: (context, state) => const RegisterScreen(),
        ),

        // Main Shell Route for Bottom Navigation
        ShellRoute(
          navigatorKey: NavigatorKeys.shellNavigator,
          builder: (context, state, child) {
            return ScaffoldWithBottomNav(child: child);
          },
          routes: [
            // Home Stack

            GoRoute(
              path: RoutePaths.chats,
              name: RouteNames.chats,
              builder: (context, state) => const ChatsPage(),
              // routes: [
              //   GoRoute(
              //     path: RoutePaths.conversation,
              //     name: RouteNames.conversation,
              //     builder: (context, state) => const NotificationsScreen(),
              //   ),
              // ],
            ),

            // Profile Stack with Tabs
            GoRoute(
              path: RoutePaths.settings,
              name: RouteNames.settings,
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: RoutePaths.editProfile,
                  name: RouteNames.editProfile,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      child: const EditProfileScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ];
}
