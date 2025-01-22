import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:codevidhi_firechat/core/bloc/navigation_bloc.dart';
import 'package:codevidhi_firechat/core/bloc/navigation_event.dart';
import 'package:codevidhi_firechat/core/bloc/navigation_state.dart';
import 'package:codevidhi_firechat/core/router/route_names.dart';
import 'package:codevidhi_firechat/core/router/route_paths.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../di/injection.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;
  final fabIndex = 2;

  const ScaffoldWithBottomNav({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (BuildContext ctx) => sl<NavigationBloc>(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final currentIndex = _calculateSelectedIndex(context);
          return Scaffold(
            body: child,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _onItemTapped(fabIndex, context),
              backgroundColor: currentIndex == fabIndex
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceContainerHighest,
              shape: CircleBorder(),
              child: Icon(
                Icons.message_outlined,
                size: 24.w,
                color: currentIndex == fabIndex
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              height: 65.h,
              itemCount: 2,
              tabBuilder: (int index, bool isActive) {
                final icons = [Icons.group, Icons.settings];
                final labels = ['Users', 'Settings'];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      size: 24.w,
                      color: isActive
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      labels[index],
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isActive
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                );
              },
              activeIndex: currentIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
              onTap: (index) => _onItemTapped(index, context),
              backgroundColor: theme.colorScheme.surface,
              elevation: 8,
              notchMargin: 8.w,
              gapWidth: 80.w,
            ),
          );
        },
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    if (location.startsWith(RoutePaths.settings)) return 1;
    if (location.startsWith(RoutePaths.users))
      return 2; // Add this path in your routes
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    context.read<NavigationBloc>().add(NavigationTabChanged(index));

    switch (index) {
      case 0:
        context.goNamed(RouteNames.chats);
        break;
      case 1:
        context.goNamed(RouteNames.settings);
        break;
      case 2:
        // Handle FAB tap - Add your create chat route
        context.goNamed(RouteNames.users);
        break;
    }
  }
}
